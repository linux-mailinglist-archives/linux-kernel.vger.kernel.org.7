Return-Path: <linux-kernel+bounces-729267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B767B0341D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 03:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCDD2168C8A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 01:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2078C19DF8D;
	Mon, 14 Jul 2025 01:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="jYZIPoUH"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86451474CC
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 01:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752455495; cv=none; b=Kv1Mn48HF+E76jT5VaYAHQFjGEf38+GdVw7UzTvNdm30L7hiWv82sKctVa1Ktx1ShApYn2WFbhj45v0OiTx0/B4iCoJPc9DINEwJDBmG3chKuCupAw1+0jHVBld/KOtS5NaVhYnAa4s6MqLosWTr33gdlGIlC6CzizeNZkRG2OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752455495; c=relaxed/simple;
	bh=j4/GUaCuAgKJAAJiuRYHkvew+9PqJ5XkKhTmQXZmkPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nw8CCBn2dFGhZ7UKaOxPrGbwDvIkpe7gs88uZPq8vlUuLeg5n6+J6oZ/EggfKTO0mWJfuU2Xo5/KRvZRut/1lS7v0A28J/uUZo5soQwhL6oq+CxY/rD8TrlxH/42g9/u2DEg4mU3y9x7cvWjy168LLyQOlEwrq6cr4lNJOMf8+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=jYZIPoUH; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ab644b8dc1so8828811cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 18:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1752455493; x=1753060293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fQAf5mzB5oq+TjOcq3MJDcg2d3RZoiYcHy403Tv2aks=;
        b=jYZIPoUHuOVJvlLy2WNjfRn54TK2l1ZlOkmVVQGWzpr7tLdLabEfPoCQEVfODAVFsB
         zTX0vLbImtRTz40gkEfOx+1ZNqQ9z0sJr/f4VA3/jg23MV9+SSTlZ77vYBHEJswxErZL
         BNA9+6SHjL1kyc6gSTJvdR1jJ6fdyiywxa7M/5zHOYEhNjI5g1zTcLGlNwJHKysdYz+D
         mjgS/Bv86Is+/NEEVvc+ChdS01YQFqInjdLcjzJ3mSSSxZ0LK1vELVob1Cx2hTbQeRsO
         WJ+JVw2TS2uCTY2jVDEv/1+oPLZow8hMswEi+9WxvlRT9CyIK+PCgklWTAR+5ApSdigr
         rz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752455493; x=1753060293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQAf5mzB5oq+TjOcq3MJDcg2d3RZoiYcHy403Tv2aks=;
        b=pPCQ6D9NTegwA6IHM4ZCqFa7T4+yMbrFzVAItyXtE96pySSzMqO/OXy8RCVfvl5ufl
         2qH11JjvB8QfWEFtS6Ar/FI0Pv7+ktK+k+e1EZRMp8PLvr2AHMkwykQyDvF1TOR1FMKd
         VVYGKSDW93guZqBMFU8V6H0tWMnp3/TpAFTwi8lM5gutGAmmvcl4SzCYBGsgfqVxBmjY
         uoPuAGYMfeYaInyEqSXdwEDMeL3vjiEsnke5/7Lu9qrRw/GKdlaNfKtSBQSvPxYPLQuM
         kVdcU+53tNpcn9ZM/LS/KldCCL9uph2f34JJjsDgouvzs1vB+noYDOTGBbcOgHmNuOVd
         11XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnrn4ihD3Ih7NyR6/o7khLSTCWjy6xHeOpq5BGaYVUE3rBJln6TZOpm/lHHmGcGf7cBcY/BAz9FqDxXlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRXrrKjn9wnu5rgekngc5Tmov5qgEItVRVUDOWZMG+dVk6xnbL
	44PRn29AncMdqodZL2/8kqHRHs6RhfOWUYtsEQ19uICkAa9avHrQgG0M/mVht8TIaA==
X-Gm-Gg: ASbGncuUHqp8HRtPuQ9wuvkacN5DxQE0IWt4glZukWU0qcxhi1hAz0VR2/R9gyoUQ7R
	tfzACzab7Z0Y+vMXNkSjJIPuLqkIZhaItiBqzjZg1iKSCqt27sJuiMgNcDr3B5qJR/y1M6BggkH
	Ub1ghGe6SRuvl4pXmCWTZcVkYIxPW65KwKIPpq+iCQ2OBOyfGeD8hevuBi0hs6uYqBF26CuYiSX
	i2iT/6tSNW/2YCSxq2Wqz3ozmLJinCu4jaW51SCVSRXUjfxyjvvzTDh8U+EQEHFLbPdlxczxtPI
	yr+gXHp185CMYK48SbakZl1Dben0Y7vNGApXXz06bXjr+FBiWQy3GkbcA++lfDMbv2CuVEfZt/s
	NAdJGow7f02QHEmqO3oXXizs=
X-Google-Smtp-Source: AGHT+IFizEf4I8/K3ZlZ4oFvSmfCwQRTQsZFlZtmLM5f9nREbt9mhf/wtWKQ5xmc6XWYkhYeeIq5jw==
X-Received: by 2002:a05:6214:2c08:b0:704:9077:e0c8 with SMTP id 6a1803df08f44-704a4083edemr229936646d6.3.1752455492461;
        Sun, 13 Jul 2025 18:11:32 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::401d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7049799e874sm42057226d6.18.2025.07.13.18.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 18:11:31 -0700 (PDT)
Date: Sun, 13 Jul 2025 21:11:28 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: syzbot <syzbot+fbe9fff1374eefadffb9@syzkaller.appspotmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] KMSAN: kernel-usb-infoleak in usbhid_raw_request
Message-ID: <56cd61d5-b821-4481-9f67-1cfff01abfb2@rowland.harvard.edu>
References: <e8fe21fa-9a2f-4def-b659-063d55a40f3d@rowland.harvard.edu>
 <68742302.a70a0220.3b380f.003d.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68742302.a70a0220.3b380f.003d.GAE@google.com>

On Sun, Jul 13, 2025 at 02:20:02PM -0700, syzbot wrote:
> Hello,
> 
> syzbot tried to test the proposed patch but the build/boot failed:
> 
> failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/hid on commit c2ca42f190b6: failed to run ["git" "fetch" "--force" "--tags" "d2f5fa5d883c5402c78965af80c005a5cbdbc6c0"]: exit status 128
> fatal: remote error: access denied or repository not exported: /pub/scm/linux/kernel/git/hid
> 
> 
> 
> Tested on:
> 
> commit:         [unknown 
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/hid c2ca42f190b6
> kernel config:  https://syzkaller.appspot.com/x/.config?x=76c2fb9aa0954fb8
> dashboard link: https://syzkaller.appspot.com/bug?extid=fbe9fff1374eefadffb9
> compiler:       
> 
> Note: no patches were applied.

Hmmm.  Apparently syzbot doesn't like git:// URIs.  Let's try again with 
https:// instead.  (It's really hard to keep track of this sort of thing 
when all syzbot usually tells you is that the git tree it tested was 
"upstream".  Grumble.)

Alan Stern

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/hid c2ca42f190b6

