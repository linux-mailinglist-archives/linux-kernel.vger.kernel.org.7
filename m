Return-Path: <linux-kernel+bounces-879187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5489AC227D2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 692823A8D0A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64B72E9722;
	Thu, 30 Oct 2025 22:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVK5IUC/"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C38123372C
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 22:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761861760; cv=none; b=Xjsa3qDacDuOiL+RY+QjKmQxzV2jjgMuUNhBDie07x6hV0M91q4Bzr31fjLtl8+DagjEt8e4nxpuPz53hgfOukPVI2ATLwW9l7qM4txyq24QvddXD8QKWbqfL5y4A4IlGC5Pf1s4DM7kjDrkHK3CBzMIbrrrZugnrjMM025pF5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761861760; c=relaxed/simple;
	bh=Qr+SKU9FgiDWHgxt9vGiPtsA9hbtwb90Iu38DdpqZs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqm32y3B6DnUQB9AYc0JpHC1wYtlY4Xin21cSleKgJ/SZAbbfhIzBwZ9JfsOSGKUKxRbIXQtFXdCjWD+n+AvLpEaJVUZTLIcoHkeL/vtUsn2bE9IPEHLXtacakq7/+eR23dsZQQjGPlsm/sfGqAW7QZWTlFQQNx6oVVriFlOsZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVK5IUC/; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7847ee5f59dso24177417b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761861757; x=1762466557; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O8nng/o7TemTjcJv19bbJKh3cyQwt5n4WNif/kXxBHY=;
        b=GVK5IUC/TCAK2v3DOTWbHVllxXunWI/010ZHzOi3nOR52xP588DxTngBMl7j7/U11M
         1GAQzeU+3tNti83Po/o4cpkoldSuK3RcbszCgENp53A67RzpopuCKTjFN2LvIRiZEZSr
         Ksuvt0cfX0h14xcqw+mWF3meWZQdfppZogIJglDPYkgVJi3l3ZJt378QISqZDRL+U7ul
         h2g0n5DaKUQjdp6OQ2IYqjRDSsosbsiBbQN64FUt34vQhs25nRAGuLP6Pl7WeiarpzWZ
         cXabe7xtTlooxqcXt8zUQ5/0nId9IWOJ984hkU79UdNs8jFpxBCYeDjraiWJ8HzxKaOX
         u0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761861757; x=1762466557;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O8nng/o7TemTjcJv19bbJKh3cyQwt5n4WNif/kXxBHY=;
        b=Fs4+NUNEuEACAOBFa802z3+XdjfD+hEB1rkZL40ajq9lSrSidY3hziYkRLwcu/zgld
         JNZHwIKFuqPLYLsMc55BFkR7bmek9FdDdgkrAqhip4WD0Rfd5th5lk2q2Dmd3zhHkjq1
         mkkXV6Tw1mYbuOHV6I8yZjCZN20fJuc55umx9lYUffrSJFG2Zdj67VKQO2YTOLRaH+qq
         bs0g3XozsV4ZVaqJM343WbggRsBVYKHW+ixkEkgIGphZus27JAmVRIHAAdfEmTEMsrKx
         YTTT80WyT61NXmd97uJ0drr7VAYuxxjWA7cc8pveVnmbBN2HeNQV6WG/bRKR0THPABaU
         subA==
X-Forwarded-Encrypted: i=1; AJvYcCUq2Vf71K18mom9+VwSGoHkKd2U23q+08zZZK32gfTxVaGcKq4lONPb3y2ISLhQ59HfQUMEzlKGAMrlXL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKx8hCR0bvdAJrhyZ6+4AilIEq/sPsYljHuNEitL4R0ucbRDI7
	CuX5I1m6xnO3o0n4yaLIBc/mbtOrv8TYb2dPsfMOcZB0edtrVT8YMvhYIupHFoT/Jb/BX5FJAno
	EK0yojFRC1j3THDMX4ZmRkPCTGPwmC7U=
X-Gm-Gg: ASbGncvF29dg9iv8XlAQ7CFGEG44MCgFBGVgFldKoBz28PAdc3196VRon8A+meSeCMW
	k1SkMxnlhzyROOkI+FI+rmxpk1NFeSuqgf6fEN1XCblojBBfB426Kp3Rd1f/PSvdl7p2SEgmBBr
	H38l/1+OW0YsjYqNLgp231o+I4Xn2sfhYplOxatj3ASUBLrqZYOR+A2PbBcjGyn51AtlY09BTtj
	ur3Z+LeKdv1MkXaNeYsATx3erZBslMF2VjYgj6AEu1n530uonKZYCAYsp//brWJDzpu/X09
X-Google-Smtp-Source: AGHT+IHYqGsWXdG1hjFBIPSMjozWYVAmeen3VtzVdRTwar1VHBzAUDvza59snllaBPPxi1yO7EYscCMwHM2FMMPXutM=
X-Received: by 2002:a05:690c:e0b:b0:786:24c1:9da4 with SMTP id
 00721157ae682-7864842bc63mr10442767b3.18.1761861757479; Thu, 30 Oct 2025
 15:02:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABPRKS9GGS2mQ46UMmM3G_NnamCsYj7zBaa_c4rQfO1h=59wrQ@mail.gmail.com>
 <84d028aa-31dd-4f8f-8370-3db4667d0dc7@flourine.local>
In-Reply-To: <84d028aa-31dd-4f8f-8370-3db4667d0dc7@flourine.local>
From: Justin Tee <justintee8345@gmail.com>
Date: Thu, 30 Oct 2025 15:02:08 -0700
X-Gm-Features: AWmQ_blrFKkGxwx84crAfwu2XHZpjpNwsFvpyVhlBY_WgnEMRx3u8t6S7gnD5ng
Message-ID: <CABPRKS-s-32fzdpyE8_7jf8r=qdzxug5xq8jqoVwcEawOgqdUw@mail.gmail.com>
Subject: Re: [PATCH 1/5] nvme-fc: don't hold rport lock when putting ctrl
To: Daniel Wagner <dwagner@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-nvme@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, 
	Justin Tee <justin.tee@broadcom.com>
Content-Type: text/plain; charset="UTF-8"

> I've dropped the nvme_fc_rport_get because it's not necessary, a ref is
> taken in nvme_fc_rcv_ls_req, so the port is not going away until the
> disconnect LS is processed.
Yes, correct, and the put would be in
nvme_fc_xmt_ls_rsp_done->nvme_fc_xmt_ls_rsp_free.  Thank you for
checking.

> All tests seems to work fine except one, nvme/58 (test rapid namespace
> remapping). But this one also fails for the other trasnport, e.g TCP:
Okay, sure, we can try to address this in a different patch set.

Regards,
Justin

