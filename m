Return-Path: <linux-kernel+bounces-817627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E1CB584AF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FDE1174E54
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068C8279DC3;
	Mon, 15 Sep 2025 18:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRWlck04"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083FCE573
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757961317; cv=none; b=fzeVJnK5NqVeunnV+aaxyNpBOZNk3FBbLWkR2GSIUeHVqZnqoG50+llp8hm37c4xSai6isxirit2PZ/QxPY209CX+wK9hMGxHInNx2WN+bmuV6VEMXrd6DDur0rHil+mH9CqfI8oZ6IT5O6XLLaL07dll8pAllCeZ19XTJoQH3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757961317; c=relaxed/simple;
	bh=QB8kWCz+k+opB+sV1nc0/tNqsdmHDtVxmRQU9TZnlz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJr+aFP3GmR+NSo4peshk42JSKdfgawGbwemDGgfJ/Zo3KfSjGzuyebPeQaBh4h0UZ90mIJlwP6pdhCrWmiFVYJ8pIBpnFDkn+8u92x21bF1ZSZceI61YBIHj2cReluzq1B7ai/FnentmpJHNuN/6kkSSwIHCxnt2g+Am2MtwjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRWlck04; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e931c71a1baso4481767276.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757961315; x=1758566115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rm47O0cVwkvg9nvwn/TiXMqZ6NlzV2ePDvDiAlLnDag=;
        b=bRWlck04AkgC0OscsFv1w9HV6uACLYjQJN+AXnQqDFrYJCNCDAH3iL39j2cPub/O47
         uu+6FiM3+1NQ8GVBXw+1Ow55gsZUSMYqrk7BDXt0ELQNDRZB0AGFMolhd63GaeyFtDIl
         cddyfU35UR6wzl4yCKgYyRDrXKeKwWS/E1epdwNPBwAKNpVUVtC1MmY2JI92mA5oP+Nt
         ealoNRtnujVMG5/cRGDd6gHcHGxrltsquZWhZ9iQSoWvoLiBUA7bfC/SWU/j+8BscwHb
         Q1rAyzsxy7sNOYhFzjfVeVrjtjcYnXjtgMbrZfcgE4eXaXDoOjaRt4mCBvzDxV9XZqlg
         XP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757961315; x=1758566115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rm47O0cVwkvg9nvwn/TiXMqZ6NlzV2ePDvDiAlLnDag=;
        b=wCfHhQGpuThzWylfxHWVBaPS81rCF/wJK4YDbTLVu8VDH622QsBwsnfTGYVPute+6i
         2buEHtELZgDVGWoCfZhSR62D1jA8qp1Dz86y1Trk5rlVD6qrV0UrauFEBGUUBMIsYmKG
         RS+g57LEtr5KxVM9qQkeirWXlBQs6l39ZOnLlcrZTThDjwG/Z+kJ8jmM1ettpm4qGlPx
         n0GQ0V7Sdznk9Ve1m7We6hUk5/mC907Rd46nwVjYp3LwAROYZJMc7XZRDq4b+ikKE2Fk
         N08b10Fgch0vAnhUW551XQeezZTrYT3Kr7OX8Q1Zgah2uCqvjCqs4W2Gaf/Wx2TO4y3e
         jpKw==
X-Gm-Message-State: AOJu0YxALGSTgcmkNuWMEv+ze5d/bQsUWNYBkVkL9Y13ia988T6LDJ02
	ZEnkD5sTnIIUhRTOi7vRs//FOnjr7fq6uugBXISeuvARx4L9NaOND48K22mjFQ==
X-Gm-Gg: ASbGncuha5QrI4qFFKLAJ0AbZpb9eayh+g9W8Ur9D1Bmf8H6wRSYbL4ho0lpkFRxwvU
	/vR9w21qTuUJSvUThxjCQXkXGGjJQcFVR1dp8aHeab2zxO6SHfrsF5iuGpXveIr3OUvbMVV4W4t
	brmGGLMtECiUMSJbEFxz/Qdzhxc9Khwxzz0N8wpKYsekHrQyDHu5F8SxFX4ijMloPlAM1vGxXYB
	4t1wm1yWWnr1gc5UcEX4Nn7LRefpzhGzTh9nCOMpIFQ1qvYYGVotdD2KwU+GZa4PX/el/2dKJZe
	ylNUjP4wuSTbgrJ/Nd03Xso1ntgcy9j1D8iiq4q8KasqKlcDTLaO73SK0WUeaWRM9F0saXV1A6K
	PaooXfk+TFXi+5auIbPJaCSCedWQKF33x+woO5T9zqOsco3qGeniYa1iCOf1/qWmch8Vr
X-Google-Smtp-Source: AGHT+IGbR4PUcQEZed/FRBSnXZEzPM5zBmWXWfE7OIcYK0EwcAuJ5/etAvpfOe5Sx1gQUcSHWjIXwg==
X-Received: by 2002:a05:690c:a84:b0:729:afb7:2a0d with SMTP id 00721157ae682-73062ab3b6amr116351707b3.1.1757961314736;
        Mon, 15 Sep 2025 11:35:14 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-732e77812fdsm16598787b3.19.2025.09.15.11.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 11:35:14 -0700 (PDT)
Date: Mon, 15 Sep 2025 14:35:12 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 8/9] cpumask: Add initialiser CPUMASK_NULL to use
 cleanup helpers
Message-ID: <aMhcYCCJDFWoxcyw@yury>
References: <20250915145920.140180-11-gmonaco@redhat.com>
 <20250915145920.140180-19-gmonaco@redhat.com>
 <aMg5EzmxG3hG7aJK@yury>
 <820443ea-56d7-4fd0-9535-b1339e53240c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <820443ea-56d7-4fd0-9535-b1339e53240c@redhat.com>

On Mon, Sep 15, 2025 at 05:02:45PM +0000, Gabriele Monaco wrote:
> 2025-09-15T16:04:53Z Yury Norov <yury.norov@gmail.com>:
> > So why don't you pick the original patch instead?
> 
> In my opinion, the /juice/ of that patch was included with [1], here I'm just adding part of it.
> If you prefer I can pick that patch and adapt the commit message to reflect only the part included here.
> 
> [1] - https://lore.kernel.org/lkml/1706509267-17754-3-git-send-email-schakrabarti@linux.microsoft.com/

Yes please.

