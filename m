Return-Path: <linux-kernel+bounces-844767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EDBBC2B6D
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 22:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EF36189030D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 20:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184C223F422;
	Tue,  7 Oct 2025 20:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHIrygQd"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839C323D290
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 20:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759870647; cv=none; b=bUxcdmgC6pjYrkIPPPQBsqQKBBscVxaa/wDd5RVg5cp9ERo9pU+uaBPd099RX0Eb9+PV8dtxXkGF/bGwGVzbvki6hlhBLvyrZGzTxvkEpyb4ag81tb6ZJomF9Myq/pgwEdaFbwhaiZt/BTYima3h+YHjC/19XP/pUc/bRC+Xdos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759870647; c=relaxed/simple;
	bh=lo+bODTqhbR+va341uGZBQme+L9mjBJdDdog2Ba/nBk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jogEtmRpE2EdDWol3i27jvDfkJ+3Bu7zqHnyl7mQRQ1bYYh0270PUu8jQdT0xWP4MaUBrlYHAqNmLyKlWul9ntrvNFGXyu7kyRIb0H1AYNDqBRyDkD3QHZpZ7ugPbM6yxgQy1CYbhdfCjoGZpGS9gbcHERxp328xRU+51JWQ04I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHIrygQd; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-57a59124323so1873011e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 13:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759870644; x=1760475444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g03JkHUsqdzLl3r9exUSIw17r9a2Np//6olnzHZA6Y4=;
        b=IHIrygQdeDczRh0ogILlLdPkfzITe9CfMZQerLdPOAwKX7FApneP06kpxGmnM3bjlf
         Br2JBFzy0z5G1uiSYkkCBEmtKEJ7oHeLdlNrtIFeXGHWFmNNbBl1hE5+pJfdoo4X3UqF
         piOIRpP0TL5pVBhc/w7A8enWukHIL9/XFZLxfmsu10fTCYWUSJ9J0Ihg0yPpLz8Gvi8z
         mZ9XKDmE5RliFOVieeAhJ0AlU4FLlPmcpFq6qdKzhk1yNOi4rn8zXRd8P71UKOR5NFR1
         ch9oNSAt7HBFP5FS7SInlJ+00nYytGqlNhO887fPSn0wfnnhVuiSaaeAKjergSbvc8r7
         qoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759870644; x=1760475444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g03JkHUsqdzLl3r9exUSIw17r9a2Np//6olnzHZA6Y4=;
        b=TEwBFjjQUKSjWiL4VwXJqiv61PLpa4mNZOdKfTdCTZTB3Hx3rW79rkdLAD3JLX8hbW
         boPRRSXGdlPpifVq47hVrpIA4BpxTp+LQHcBpGy5L5Sz2eDhzqfFC9jRre38a10mDvGs
         k9biSE5E11qOEzpHa1gwgUqdatylokTH6xPMOjtVzdV37TmLl6GnGxNogAq3Ikqe/YNF
         PTSZwkX5/Y9etaLWPfQjRCDjq9Wam1cwSUlBkVIndJ+/WZfVI9DopKbFI8FTLq8gYHfF
         kVdVR5UZBgY2BZQ0EAmcgBfEiPhiiguBYlV+PAlf4xWKsG/c35XMEOMkBFs6dSBiUCUc
         1oXw==
X-Forwarded-Encrypted: i=1; AJvYcCXMnJsdZgRJX9uKDc2dV/drh6LH43kGhwupf+J1SMvLz6oytSUusmavgF5vJGDz+mV7XcNFBoX5cRf8rT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyoBsr8wrdHlAkBgKCIJKFm4Jod2kbCkUgzcxG/pUGlELzvurE
	8N24ZMrAIDjbZ5/+VwUy+T4LN6ONwN3pOzZ0pqknluPo8xv6krKIzAuN
X-Gm-Gg: ASbGncvf+WKdUxP+uybcoYJrPM1OQlYV5yHTj1vWXSMxSefvVBUThIe4t43AYWNre9Q
	mrLXny8m73Bz1WL9SWfCZH/43kjJba2D0cXuIKqZReje+afdVeBtMVHncDsEYWWubJpla3o5Du4
	7Oqra4Gg+Pu6wKAaeEQEJfi65f+1thcKls1EChHojXJjZRlYJfVcPIxFDw3ZaOZaB/08+1o69qh
	x8t9an5YW2GcHGbFCk37HH7eM7YWU+sR0fiTtXioDPPHH+DCkEMjagusI1QyaXGu1OvxHqE2tz0
	SiSwYHkHVZqhyHs0mxDMzXnkeDNcuKSKkKLqMjwEmSvqUcHM0SFE1Vb1OolCw7Aq8Kz+d7UBw8n
	kmo7GwxsSer8QJoTMal1YicG/o/edH1oNbfQjoW+fcMLOR9B/uMi7g8t2WtA=
X-Google-Smtp-Source: AGHT+IE3t6erqilqr2vkNvErtfsN1Weu9WLJEnPCNGwz7Ro11VdzfSyM+y127Q8YciWZY6HpkBzUsQ==
X-Received: by 2002:a05:6512:398c:b0:57e:4998:95ce with SMTP id 2adb3069b0e04-5906d8ed6famr305072e87.35.1759870643322;
        Tue, 07 Oct 2025 13:57:23 -0700 (PDT)
Received: from foxbook (bff184.neoplus.adsl.tpnet.pl. [83.28.43.184])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0112462esm6473271e87.3.2025.10.07.13.57.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 07 Oct 2025 13:57:22 -0700 (PDT)
Date: Tue, 7 Oct 2025 22:57:18 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: guhuinan <guhuinan@xiaomi.com>
Cc: Oliver Neukum <oneukum@suse.com>, Alan Stern
 <stern@rowland.harvard.edu>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
 <linux-scsi@vger.kernel.org>, <usb-storage@lists.one-eyed-alien.net>,
 <linux-kernel@vger.kernel.org>, "Yu Chen" <chenyu45@xiaomi.com>
Subject: Re: [PATCH] fix urb unmapping issue when the uas device is remove
 during ongoing data transfer
Message-ID: <20251007225718.3c8b2cd8.michal.pecio@gmail.com>
In-Reply-To: <20250930045309.21588-1-guhuinan@xiaomi.com>
References: <20250930045309.21588-1-guhuinan@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Sep 2025 12:53:08 +0800, guhuinan wrote:
> From: Owen Gu <guhuinan@xiaomi.com>
> 
> When a UAS device is unplugged during data transfer, there is
> a probability of a system panic occurring. The root cause is
> an access to an invalid memory address during URB callback handling.
> Specifically, this happens when the dma_direct_unmap_sg() function
> is called within the usb_hcd_unmap_urb_for_dma() interface, but the
> sg->dma_address field is 0 and the sg data structure has already been
> freed.
> 
> The SCSI driver sends transfer commands by invoking uas_queuecommand_lck()
> in uas.c, using the uas_submit_urbs() function to submit requests to USB.
> Within the uas_submit_urbs() implementation, three URBs (sense_urb,
> data_urb, and cmd_urb) are sequentially submitted. Device removal may
> occur at any point during uas_submit_urbs execution, which may result
> in URB submission failure. However, some URBs might have been successfully
> submitted before the failure, and uas_submit_urbs will return the -ENODEV
> error code in this case. The current error handling directly calls
> scsi_done(). In the SCSI driver, this eventually triggers scsi_complete()
> to invoke scsi_end_request() for releasing the sgtable. The successfully
> submitted URBs, when being completed (giveback), call
> usb_hcd_unmap_urb_for_dma() in hcd.c, leading to exceptions during sg
> unmapping operations since the sg data structure has already been freed.
> 
> This patch modifies the error condition check in the uas_submit_urbs()
> function. When a UAS device is removed but one or more URBs have already
> been successfully submitted to USB, it avoids immediately invoking
> scsi_done(). Instead, it waits for the successfully submitted URBs to
> complete , and then triggers the scsi_done() function call within
> uas_try_complete() after all pending URB operations are finalized.
> 
> Signed-off-by: Yu Chen <chenyu45@xiaomi.com>
> Signed-off-by: Owen Gu <guhuinan@xiaomi.com>

Hi,

Was this situation seen in the wild and/or reproduced, or only
predicted theoretically? Was the patch tested?

I wonder what happens to the submitted URBs when scsi_done() is
not called. Since the command URB was not submitted (or else we
wouldn't be here I guess?) the device shouldn't have selected this
stream before disconnection and it seems that the xHC won't try
to move data on those URBs, so they won't complete with -EPROTO.

Will they sit there stuck until SCSI core times out and aborts
the command? That's poor UX, speaking from experience here.

Maybe it would make sense to unlink them? Unlinking Streams URBs
is a sensitive topic because it's forbidden if they can become
the Current Stream, but in this case it looks like they can't.

Or am I missing something?

Regards,
Michal

