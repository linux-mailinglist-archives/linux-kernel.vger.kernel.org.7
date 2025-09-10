Return-Path: <linux-kernel+bounces-809192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEBCB509D7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 02:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E0B24428C3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 00:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CB27D07D;
	Wed, 10 Sep 2025 00:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G85UFioH"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AD434CDD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757463329; cv=none; b=WXLXIfzTR4TsUtb8BhJjWkeH3zyK+d9B+39+MfR4FhAZrkcYL/uR47/MDNQHNKhAJ6WvBofJCf1Ivn1JRtuwCN882HtqHzD6rRWmtm/WYqr/jJvGtK20sxjVN1rPQD1KWs+3RjMh1E38WefQwLz0LG3MLhukhiU1u2Ysla6foMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757463329; c=relaxed/simple;
	bh=/QwJlyePU0b3Dl0rXRsObE0IjaLGEP9+1Smt/QIJQK8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zs7AlR40tgApU7AHK0t91rRn7Eu0y/5L2lkGmMKO8cDe1vreop6RhzT7kU/joUF8pbHGo/NzmGm89VyeTPbRr5/kZe4t0aXaq/v+NV115GQq7ZeeloX5EqXQLcCP7tok3h8KxuTu99DZKBzLk96uITS/LvkfttnkufwuhAbM5xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G85UFioH; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-33ca74c62acso27105861fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 17:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757463325; x=1758068125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xum5CMs8mMk75mYskxfHKJ6AidH+157mXUqQ+APsAo0=;
        b=G85UFioH0GZjQ0u4Bd5HEmQTl8sBPt5Ui2XzHHLFb/aGDE4kW9PfjSFhCBn5oLjOiP
         YKDsfDfdnKknIc76Pj1YKn64tRkisdzOr5AhqB+vyNsdY5T7YHWrVyYIZwndj5/ng2Yu
         Mwwe06rYp2LvUypYNkW2z0GQSw0fhDnDA19HxL110HsFah7QSLYO1g79tdqy2Kbw0vNs
         Us/nqCTEb9kSelDHyM2vWlYiyzdrkpvHmY1Xho4zOwvGaMKKgTpoLq8P7DiLvjsOh/Gu
         vcjm1ZOSNPkTXCD3rmUuW6XVL5d5cxyUDuLIq4ceSfpi8xr+LEq8czL5yZ8QNZCbeXXq
         ErHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757463325; x=1758068125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xum5CMs8mMk75mYskxfHKJ6AidH+157mXUqQ+APsAo0=;
        b=CE+mnNbOKqvB7az7y7u5jF7UY7g01HGwz0qdCDOYF5V8/HzzFr5PpuQ7nNkPj5eMK2
         4wrBkfBPsj/r0xNrVXYrSrDGFBgthGpbrzLnTFvScIY4iyz8yCUnrfJ+Sd5WkwT8QpWj
         QUCwcz+QG2cEy5cmrtgXuyiop+IGmeT24kxAhN6dj9KmpWW+o94gPIIY7HilLqcLzYIx
         e8IisKBWgCEn5AJeWH1PRpofkaozaUlkn1OC70sCwOvH80Yd6HX+0FQQ/Nqtl4ufphsf
         VxRxBf6JWesFdCX54J7plgiNgdG44PNqiAC6owzU0G1FrWP8bJO+va4FBG+Q3I241a9u
         XMMw==
X-Forwarded-Encrypted: i=1; AJvYcCXmnrV/tJHw9gaOmyP/goXxU4tqKjO7kBjc2JHnOK4SuDYT8HWYRoiSk9PoaNpXr9U2quUXesgoT68rdgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyzMC1rkq60JNplaRRpcKMrdJUCHPHOakGEUKF8xOQjCKeQTa5
	XFjrch97YXaSUpg2sBUVnedVezndXzru8PdXYaaKgnsI9C+9dZz0Kri4
X-Gm-Gg: ASbGncuAUN3zzqxtcyQp2EWPbkwfpmOVsFa4MsvYyF3pxlub83upyIAtP9h0DeX93MY
	s49wM1vgoc3CAFDhimo5+9wvPcgBaXe9JJV6uOUW0tAGnO25qw7JEtPnBpZPtD1J0I2corpEYiV
	QfgMa0LtpLBv9uxBTwCV6VpzWwt80jFnLAduMuzZKRX2ONC3iaRZQcuqAOnBXojLQcQjeM9gCOT
	xC1U457eILErcumc0glfDbT4YU4FgJDTIB7Qb5zPdwMNDW5pTS9wVYBeDy8BMY8wBFNPkg5DXsz
	kTWnjoKu5z7kZW2e2ag9gu37uS01sTIAaIfRfMo8LW1seuqjFGjuOSrFZ25ckpCE2k/CgNQOvZ3
	MoN0LaUDAJQZU0AYM+RKxY8bTxgslLVBiH0M=
X-Google-Smtp-Source: AGHT+IFka9XkCsv9D2A5AOl//LQDsElWPwud7RquIhR3+t4z5tn5JD2JnCY73Sl2PIMzaax148aq2g==
X-Received: by 2002:a05:651c:40c6:b0:336:87c1:74b with SMTP id 38308e7fff4ca-33b4c47cafemr28027411fa.11.1757463324942;
        Tue, 09 Sep 2025 17:15:24 -0700 (PDT)
Received: from foxbook (bfg216.neoplus.adsl.tpnet.pl. [83.28.44.216])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f50606e3sm42067051fa.46.2025.09.09.17.15.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 Sep 2025 17:15:23 -0700 (PDT)
Date: Wed, 10 Sep 2025 02:15:19 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] usb: xhci: Queue URB_ZERO_PACKET as one TD
Message-ID: <20250910021519.13f78e21.michal.pecio@gmail.com>
In-Reply-To: <20250910020306.1d77d7e5.michal.pecio@gmail.com>
References: <20250908130128.7ed81912.michal.pecio@gmail.com>
	<6ca18b05-80d4-4988-bb08-3cad003e10f4@linux.intel.com>
	<20250909193859.73127f85.michal.pecio@gmail.com>
	<e29fa12b-55e4-4ab1-b623-11feb447bdf7@linux.intel.com>
	<20250910020306.1d77d7e5.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 02:03:06 +0200, Michal Pecio wrote:
> On Wed, 10 Sep 2025 01:57:39 +0300, Mathias Nyman wrote:
> > On 9.9.2025 20.38, Michal Pecio wrote:  
> > > On Tue, 9 Sep 2025 16:04:33 +0300, Mathias Nyman wrote:    
> > >> Adding the zero-length TRB to the original TD when we need to send a
> > >> zero-length packet would simplify things, and I would otherwise fully
> > >> support this, but the xHCI spec is pretty clear that it requires a
> > >> dedicated TD for zero-length transactions.    
> > > 
> > > You are right of course, an empty TRB in a TD would simply send no
> > > data, or maybe it's a TRB Error, I'm not sure.
> > > 
> > > But this is not what this patch is about - the trick is to use an
> > > *unchained* TRB, which is a separate TD from HW's perspective, and
> > > to count it as part of the same TD from the driver's perspective.    
> > 
> > Ok, I see.
> > The whole TD without completion flag does worry me a bit.
> >
> > We need to make sure stop/stald mid TD cases work, and  urb length is
> > set correctly.  
> 
> It looks odd, but I can't find anything wrong.
> 
> 4.10.4 discusses what happens when IOC is clear on the last TRB of
> a TD so it looks like this is allowed.
> 
> If the first TD halts or stops before completion then it doesn't
> matter that we cleared its IOC. Everything works as before, except
> that Set TR Deq will skip both TDs and the URB will be given back.

Well, there is one difference, but so far I found no ill effects.

All those (ep_trb == td->end_trb) comparisons will be false in case
of an event on the last TRB of the first TD, currently they are true.

But it should be harmless:
* COMP_SUCCESS case in process_bulk_intr_td() is impossible (no IOC)
* on errors, we may use sum_trb_lengths() unnecessarily, should be OK.

These are the only such checks I see. Nothing in handle_tx_event()
and finish_td(), and from there we go to handle_halted_endpoint().


Generally, I tried running this with wMaxPacket=64, TRB length reduced
to 64B (patched xhci_hcd) to force multiple TRBs in the first TD and
with transfer lengths of 32, 64, 96, 128, 192, 256. It worked.

I can run it again tomorrow and send event-ring/trbs and epXX/trbs.

