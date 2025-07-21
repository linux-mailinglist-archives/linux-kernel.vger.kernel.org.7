Return-Path: <linux-kernel+bounces-739383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F08B0C59F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66871AA33B2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CE42DA760;
	Mon, 21 Jul 2025 13:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="lq8SPMXE"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A0A2D9EFA
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106195; cv=none; b=VZd9jI4ckFK5r/LV/rLsvtmevKkMLOvdxGom3j1fBg/to2pfrsHVEUvBi3bKVEF3urB81Jcmf+tkeKjXCChszNWqnNMusKys6SKPP6RQWYGItRWP4kcTY88/vUuIbh75KSAE6JJwQjzWkKzfooZSw8hZIRUxeCNzZ1B8Sc0mCU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106195; c=relaxed/simple;
	bh=dPKCxPuKbnARZmFAvXLIPHV7lE2nBnxTOg798f9lPzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSPF/d9S7ogYAeoZfp2bzP2nPPdvApg3iRA5XiuokRSeV+SWe+tyoC8hY8pXwe+YPPKPG+e+DjBQN6PcWQ/Dv1NqYTqli1EJj+K4kejug115P2jIKQF5stgqizoVEGewpU/ZvflYkisd6oYKcpWHAdHPoZftxfR4GLlyzBs41Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=lq8SPMXE; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e34399cdb2so467946485a.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1753106192; x=1753710992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4mZizasBGrOKX286he/4jUYttTXz4ly7ZOMJ9seeQQ8=;
        b=lq8SPMXESw0ds2oDEE2VLQPanYRHqnhhH3WDY0H7v62JpQJMRCzUjBQDkAaJZP5vFD
         yN+vpd7q9h6Z5bCNqVsJEvjgRNqLqT0ahllfAD3ikzmCPfJRs9HfPPf/OMsFl85DTzUJ
         rvkVgVb7v/WnSyp9sNJzEzs3X/ZzNYy5KbMq1v1hSNgClGXBxNhYOgaJYVU7s67tZtF8
         g+ZgdLuCoCtkVXyMrM38DrpNQ65QKhRUtXB1eVKK6LmpT/MNW7fO1wYmkrTFUzoQ5Oh5
         gkI/3AmB3KJYMcBf1xZzzHec4bjO4VpIECjXxZ75tz0WpNgs7OubPb4M5yjXVhP7VQRo
         ioOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753106192; x=1753710992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mZizasBGrOKX286he/4jUYttTXz4ly7ZOMJ9seeQQ8=;
        b=C09eO8lOSOZelgi3nLCMbQxU+btUm+XGw3T40lhPOOcnTRPU4a+E49w+mDwHGZqIt3
         A7f5f1TADNO3UamUBYRFDl/5EveJ9/hmnt9C6cd9WNG6nsn8pei8xjI0k8cbPiDoFJNf
         WPwZ26OShGn6oU/M0qf0t8xk/U1TAt8Tl3rJi5xF+0FgAsX9FUCCky2IUtXGPMt378cY
         lmiMhFUGdNzOY5YxvaIN+c3i+Zts4enUYGQVYCLdPGnicgREHsm7ITIF2dU6Cpawo2QH
         Tu0Aa1a4tgkbQ4qLVenvCy3Ynt/UM3cEy+tQHNvPloK41ET0oPCLEcINXGzNqkFcSCNE
         Crzg==
X-Forwarded-Encrypted: i=1; AJvYcCWanng99LvOaVVrdW+VbN2mxKpBd6STcHp7ka3fvDGn2QDXXk/Dneay1TD7mPPW1P6u1Hw07fnQQPKP94Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMxXzG+++EfF9b+65CDHVjVIaG8kvywCEmn8Nrp/PQ7T1F0LQu
	lRN0qVbnNdCxwFjImMqUUlmIF2P6LBK9WFo+MkNhtunknNyb0PFl6JZfTsUVm5ymjw==
X-Gm-Gg: ASbGnctvKrHWl2X3i7PJrQkZAgnYoz+JgdJlymoABNeIi39ZMIzc5QtcVcx7dOtKi1e
	7m1ZR/jTQNn0Y1KWBtXAWPfMvNYcj2B1l3W5LZ2SosLC2rWdWTBM8w9sDkDpwZh34uyqtZdgdVH
	XlZL7aHgwjX+WA/I8Mmbh74Oejgtppr/EDp8IBC/os3uMIhKmNtdo1KHtkJEfd261hOJBJL1w9c
	RBfX6TGShOi2Hc2Iti7+m/bSjK4KClfqCPkH3LFknNGsUGiTMDDXibs8tFeaWaPB+VoA1bsKzjR
	YHtJd7ZVwpVQVwTH1UN1Mcts9+jyIUN96bK2zzVpxB8qwbBQiraEyyuh1r78vmDK6zN8AQVW4x/
	q89hE4SwYmH1amYG62iqruDHuZ9u0RmSz6Ljxa8dx
X-Google-Smtp-Source: AGHT+IEFOjtze/GcOfDAyVlsxsDrjUvwqSQ9QbXI5FP3ajBJ7ugfJ765Hg7AXfE0JqMEmf5eEalp6w==
X-Received: by 2002:a05:6214:801c:b0:705:16d9:16d8 with SMTP id 6a1803df08f44-70516d9181emr141743746d6.6.1753106192193;
        Mon, 21 Jul 2025 06:56:32 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051b8bba61sm39397356d6.14.2025.07.21.06.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 06:56:31 -0700 (PDT)
Date: Mon, 21 Jul 2025 09:56:29 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: syzbot <syzbot+b63d677d63bcac06cf90@syzkaller.appspotmail.com>,
	jikos@kernel.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] HID: core: Reject report fields with a size or count of 0
Message-ID: <bd033800-53f0-4d5a-a52b-b0e01ac48c12@rowland.harvard.edu>
References: <68791b6f.a70a0220.693ce.004b.GAE@google.com>
 <8a4eb6b0-f640-4207-9f05-83e06080410b@rowland.harvard.edu>
 <lrhydvc7huuqck2kvqzobqt7hhwt36zwsa2i3fpegbpykt5q43@2md6gfitjlb3>
 <a2c3537a-8ddc-467f-a9f4-b4d413914914@rowland.harvard.edu>
 <voiysrjm3okjtaz7axqupr2jk5yyvxsqgagbwrsey4z24g6rf4@xb75ss3bwol5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <voiysrjm3okjtaz7axqupr2jk5yyvxsqgagbwrsey4z24g6rf4@xb75ss3bwol5>

On Mon, Jul 21, 2025 at 03:05:58PM +0200, Benjamin Tissoires wrote:
> > So then would it be better to accept these report fields (perhaps with a 
> > warning) and instead, harden the core HID code so that it doesn't choke 
> > when it runs across one of them?
> > 
> 
> Yeah, that seems like the best plan forward.
> 
> [sorry on reduced setup for the next 3 weeks, so I can't really debug
> the entire thing now.]
> 
> Though, we should probably not annoy users unless we are trying to do
> something that won't be needed. I doubt that Saitek gamepad will ever
> call the faulty functions, so why putting an error in the logs when it's
> working fine?

All right.

Probably the best way to do this is simply to revert the commit that's 
already applied and then merge a new patch to harden the core.  Would 
you like me to post the reversion patch or do you prefer to do it 
yourself?

Alan Stern

