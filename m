Return-Path: <linux-kernel+bounces-893117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BBFC468E3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 33811342148
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD6117BA6;
	Mon, 10 Nov 2025 12:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlCTFVbS"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2EF48CFC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762777093; cv=none; b=Iwwiz2SFub+oDNbRiZ4D8Qf7FcuS7vAjJlCf1f6XmgTYho6LZEUJ6W/OkXukZO8nc9qBA/mYGI4930o9WFBMt7GRW0yG8dJihE1RmKWwicLaEXZAppduynCogQm5bSLAkIpDv8g1/U7bUhUCuqexY8uXqiqh72bN22FqOtDmlF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762777093; c=relaxed/simple;
	bh=hnlXhM5R6vBt5fo6AytqU3xp9n2jHDQI4xuCqqgBmwM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HDxKsH9MJToeYwhJs/Ow8gV7uNYf+yU7rSFgDtPNj2vVJBKtec5+qBSft7XuNSwnFcZDB9z/bz+Pr3jbuC4/BXNHxtkgyNQY9oXHSrWc7NEUTXyMosSHdqyxNDfPxLFMu4gfkM1VtqMICgI7We8pce373x16WlzOnEKc1R/aJlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlCTFVbS; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7aab7623f42so3371490b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762777090; x=1763381890; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oBxOc5qfBcOJZDqRmzm+wULwya9/QGtOyJO7/xhluLo=;
        b=nlCTFVbSzu5orXt2JaQfnsTRLq3bfxukUycPFQ8Ea0+dPNeeVvgyFTWc+YcLYnU4p5
         VgBBwwii8Xi75qBVNC0UnwsNmLBu8kHnrfE+zxBP7IpBpDnZeSUlzrH/+nuv3PmXMQSA
         J9qrkDZGbaK4qyN3opseB3hJAR6pSYDZSrb+r/ZAy3ynWb7cqKJsn7sNMDAkPKGjvILj
         5zhJ3b3hq37mRk1p+mX9DhFoI3rXgYCd6Y2opm+5INdfDsXJsNm7kCr4+FHy85R6Tb6V
         N5YLMoo9XkHTXcZZJkFZvhPqk+59XKFvtaCw8ao1xfcMuCzXxjnQ3s0JC9ktO9oJ5obm
         CMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762777090; x=1763381890;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBxOc5qfBcOJZDqRmzm+wULwya9/QGtOyJO7/xhluLo=;
        b=oO1i05vfU+TuJoWXb8Qsd3LvZvxHy6OSIBOSDpneiMfzEhTouDQyHrYuqgsIiawHkC
         v8LPZJ4vY8pw7kNnbO8pofUQbJ/u4Dm7TjrHNGWDN4/ElQN72RUMdzC1qpChpR4hOp3o
         L9IYMCtonfjSBwx3EokOY9rRQM2Kv77fzFzSMXLvs0eWgVagc+kP/mwuVrGzpHWdn2D8
         UNCpoL76FpuFtRyllPwYqqtwBxXaEJg2VWiosyqi51MnwkcpSPFzMS0Yer2kmhOm63tq
         Uxz4zW5sNf6rZSm6UoVdYuGdjjsxFiELnK0tQ8YPxcN96L8qf3mmj1kfKTWPsPXHZg+c
         U0eg==
X-Forwarded-Encrypted: i=1; AJvYcCVCjHj/RC69Zbyu/bdEOlAg8hJU0lq8rd3G90IGWi7lVpV5V+5+KIFSRfqzaAoUKR+Y57tnieONZ1Q0M0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwetqMI81C+s6W7tDutOvKyTI8is0QKBKRWrwMMzZjgfiIW6B55
	IKdVMCAWAqVMPPDLKZrNXbKgwAOqh/qNf04OWTd2WCzNtNyhYSp7CKItF1tvdA==
X-Gm-Gg: ASbGnctRgfwYpvmlQSD2hpg/xZzmTJ0PPWC5o5corG/fsUJWsB9wxTNPL59M232eOxt
	kOV1e6LUalQQI9kROsso5AHBGWpbsZUCtKGDv7BcfFWGwxC/Ib+BCwtDb4+eNMTqD75wFCBfoGU
	LZ0oYrdB6XwqAgwQrC8pKTQru/LCwTpngfxqPdDXSEQJpPknnx4jTg3zWqmwoUtKBC04UZZSxjf
	6wq2qIcnJe2TPhJpi5A997SQ8eRIfOeHvpCDju3Wf1rg7xbuDy7z0uJCMVd+wsryTGN+IP3WMM0
	aBPyFyoJz4zH4NhmNAoB0VcX3E1c0DHxJCH8eM83rd5VKEnq+GwqUV9rd3Ny+zsrT687azOEDx4
	p4mR0run7ASH+Lc9emFqo9p9D2zSUug9ah0EDK0XqaeTeHqvpS3KceIEPywwR9zf0waBvIMIrwB
	R5/D5pfspuC2p93B6pq9T57BsjY5VDSfhFdDSwc3g99PnbvmJ0JTBGSH/ln3+S2Z/HJ+N2xHWk5
	uLU8n2tHn4Ek/c92owO/w==
X-Google-Smtp-Source: AGHT+IHHASQUV9QkdfBzJ80+YLK4VSdlwhzAh7FRSiwznuCW7X2R7SNuVB0qK7gA4LbbzwDOGQTcdA==
X-Received: by 2002:a17:903:40cf:b0:296:ec5:ab3d with SMTP id d9443c01a7336-297e570a922mr108833405ad.61.1762777090029;
        Mon, 10 Nov 2025 04:18:10 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-296509682casm144137395ad.22.2025.11.10.04.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 04:18:09 -0800 (PST)
Date: Mon, 10 Nov 2025 21:18:05 +0900
Message-ID: <m2framxerm.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: hch@infradead.org
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 00/13] nommu UML
In-Reply-To: <aRGs8lPjH22NqMZc@infradead.org>
References: <cover.1762588860.git.thehajime@gmail.com>
	<aRGs8lPjH22NqMZc@infradead.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII


Hello,

On Mon, 10 Nov 2025 18:14:26 +0900,
Christoph Hellwig wrote:
> 
> On Sat, Nov 08, 2025 at 05:05:35PM +0900, Hajime Tazaki wrote:
> > This patchset is another spin of nommu mode addition to UML.  It would
> > be nice to hear about your opinions on that.
> 
> I've not seen any explanation of the use case and/or benefits anywhere
> in this cover letter or the patches.  Without that it's usually pretty
> hard to get maintainers and reviewers excited.

thank you for the comment.  I tried to include this explanation in the
document patch [12/13], which I copied from the text below.

  What is it for ?
  ================
  
  - Alleviate syscall hook overhead implemented with ptrace(2)
  - To exercises nommu code over UML (and over KUnit)
  - Less dependency to host facilities

the first item is for speed up, the second item is for more testing,
the last item is for more extensibility in the future.

Early version of this patchset included this information as well as
the whole documentation, but I removed it as the versions grow.  But I
can revert it to the cover letter if it helps.

-- Hajime


