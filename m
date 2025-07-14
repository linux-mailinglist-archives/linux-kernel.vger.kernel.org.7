Return-Path: <linux-kernel+bounces-730093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0807B04026
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA7A03A3D62
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D911F2571C2;
	Mon, 14 Jul 2025 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="Nxns75rw"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE7325229C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499929; cv=none; b=bsETeNtNrQwRjEb3PqmKJUESgndnDjTwsjlhlYeVTHbXgwgnTYE4zhfxnLD+r1lk41OhZnX4G7QesFaKUVn+ndgCqQgnLcvxKGRzwD2Y87w9Qvc66n6cAu2ZvaunrAHBuSYNVJIvcirDJGeJVRGtgsBrP6c2/XfZDrQH+r4XqIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499929; c=relaxed/simple;
	bh=o6gSA4iRI17tVBKBvXibBGdjFo1+iPIqRviexnz/ZOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQR52Ozpui930qjVaJtPsZ9ZExVpcnZLYQX75m6O65kyNdAdXLg2KIF4N+z4dUA1Ro1BscLCn1kqLjhEJmrPDFG7zAKKicoClbsYYG3TRjYg7O1SI7BGSJMm5tz724eIN82v34wexnyXf2ItnW74OgkkZVAG7sIwf7115WAyxFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=Nxns75rw; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6facc3b9559so57065896d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1752499926; x=1753104726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6xBkPh8bpRDbDE/rpTA1xUCWQKllGijDoGG0L7obvbI=;
        b=Nxns75rwscfW0S3/9Op6Vv/x8D7p6l3jJ1KqrpadOQB6E248W/JsKFOnIal2CMAGz/
         QLl2yEdVqyf7ysXBaXWRBo6QLo3zb8/7eLWDXMl7HHZgvjiushOUDAiMcxcT5Gsv2yNp
         zVQFZ+Kk5KGikOMnH68u9chbAPNueHconi9LAEvgSll7iXHFGpA8OSxZRc1S0jyy6pfE
         JyKFHupn0/5b8ngeJVAbbHhj+qPSJMbKLOAYPfxHA6hUNIY4+GN6culNc+re9+OXXN2A
         b61wYZaQWg4Ok/HHpy9FdKG3hCkD14x76btNf+9qdObz7EgyarwbsjH82fFfTgj8B8jM
         QmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752499926; x=1753104726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xBkPh8bpRDbDE/rpTA1xUCWQKllGijDoGG0L7obvbI=;
        b=gvI3osGb1KoI/1ifDJs4aoIVzq7/23PkatlUbPUq/8kbb5PA/nendnGv6A+iIgfB8q
         kTJbow9IrTqEGqaEI+/LkyMMWa2RkKwbOp3+TZU0zY06cYpl5rHRKKiyg8bSugMC3/t8
         px1ut+64MoWEY/CtjeHpwvqHM3aJZhJg77BqyyxzqmZcqS//cAt5ejqI41qsmg7bowtJ
         viCuUTD/vbSXnePNmPCV/DK9D+OBrFHreYETsVBdEqAbJHbPlFQVj9R9qMMLauKVp+BJ
         +yq3THU6ctwQ+iDW83BpfAp9UxinM+16XTLASeZw+43vfOQ1fWPsiV56wNw202QKzGvr
         CS5g==
X-Forwarded-Encrypted: i=1; AJvYcCWFK6ug6aKUNITCc658QgFiTXiohllv0P+2LU12SYHFrreiUSHazS0mP2ojNfO6G7MhxVJhh/+zZ9Sok3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPNLUyNkxyelE9x98uXw+2f+Zls1KBytJoh2cEh3lpDMDzthPC
	wQd+3kOP6VzAJd2SAvHc3RCWL4k5rCxQTpgGarkJF8GzSq05Gp2aVAK9RDjr9BVUaQ==
X-Gm-Gg: ASbGnctqDVlQoX4m4Ucz+Zh1W9gKNCGtEK8gCtehjSZ7kQ5LXxcgguEnEy2HJEgQeoo
	qS5r1/lqq15WSmph08l85dRSOl5U09B2GIPstTpzqYIfyqy28kJDzzEWfttkoxSP44dLsMlkvS9
	pRxJjykVsgkn0dfyfJA1Qd3pSuGWGZpKTu+dFX0I4fW0R7oDxrw3+VWqedV9MVsMIe/ZpsmzpRr
	/FD/1nLborV2fwcOk9qA6QTwIFU5LX3KToXEaoqdCTtavlbuYyPBM0lRgghgr1Dblr1NqUdbU26
	e/ULlvnZ9kZRXm41G/8bxupBSg92Gi0g6QRTzylJcgKrTNf9KBi+XkpaGY3CDvQltJxPyXayaCa
	xYp94ELjbJ043zmeAsUal2Wk=
X-Google-Smtp-Source: AGHT+IHcDlRJdgLbWczO/0oWQhJ09a+Chve/NcLaTIVCSDBaS66RcroV2AomQZA/4l33Q7BCJCQN+w==
X-Received: by 2002:ad4:4eaa:0:b0:704:89de:f2c3 with SMTP id 6a1803df08f44-704a3a86501mr196941696d6.39.1752499926309;
        Mon, 14 Jul 2025 06:32:06 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::401d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497dd4a06sm46959806d6.123.2025.07.14.06.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 06:32:05 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:32:03 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+fbe9fff1374eefadffb9@syzkaller.appspotmail.com>,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] KMSAN: kernel-usb-infoleak in usbhid_raw_request
Message-ID: <a8129780-de7c-47bf-a491-0d71afd60c21@rowland.harvard.edu>
References: <e8fe21fa-9a2f-4def-b659-063d55a40f3d@rowland.harvard.edu>
 <20250714024903.3965-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714024903.3965-1-hdanton@sina.com>

On Mon, Jul 14, 2025 at 10:49:00AM +0800, Hillf Danton wrote:
> On Sun, 13 Jul 2025 15:19:34 -0400 Alan Stern wrote:
> > 
> > Try again, but with Benjamin Tissoires's recent patches.
> > 
> > #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/hid c2ca42f190b6
> >
> #syz test:   git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git  c2ca42f190b6

Thanks, Hillf!

Syzbot is a great tool, but it still has a few rough edges.

Alan Stern

