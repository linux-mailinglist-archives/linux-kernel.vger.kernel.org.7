Return-Path: <linux-kernel+bounces-863396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 094ABBF7C6B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B1EFA4EE19C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCDE2417C6;
	Tue, 21 Oct 2025 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yBCwqNBg"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B01346E5A
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761065265; cv=none; b=jiI7hbTaYP00/j5jVqdOXoa4afLaEthBeTgZNoHCBg7uXKvjFeR8n79hoFC7QyXsu/rjlCR2wsg8TA1fxrODROWcdq/XtAASg4r3xy9/LQVDyQ5+0RZpX/+pNjJKbbHQXEwsXRaddHW1Qz/kLi+ep5jnLCQWbyexxFczRfA7dec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761065265; c=relaxed/simple;
	bh=vmo9iwuWXa2Qo1hdNIh/2vpO3AB9WtxtaHeat68xtJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qg3+PoCCueBHXjnh73u9ZZV4Ed5WvJgGGAHmprkxDCaf3R55aP7aAd9Ltr/vGcbm5/YtKDhBhWwFaFOBteo0thcHWWFYqOHAn6sMknbgCIYAHAZSuaI+CnRVQivKGhMMeRoNYlQ0rCNGUvymwhyfyUAYSlWERLiXS9mKj+XjWCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yBCwqNBg; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-781997d195aso4450465b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761065263; x=1761670063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OT9BDqZbtTZ8FlPJwy4YL51bMKIbhKLdUmKCp9QkH1I=;
        b=yBCwqNBgAyLwZUIE6ghV6qXDz91US3DrL9/PMoUeEr8unL/Uo1OV82rXQoIB8dlRlj
         OM3aqLLA4NmquwjJlGU6iiemb+Y0FA3kki90zT4sd07YqPtv68sQVjqwGjxq6Xkyh4yR
         p/vqlyzAmtaWyq1k7dnIiHGJGllVnivl+Byxd8ZV38ZCsYBz08HbV7fgO7SlMQ3H5e7w
         lMit55mxcVmlOCvsJ7IUO2BUZWPQn83cecNTQCRXDhvG/qVmjPHyM7jswyNUsBYeCKL6
         uGe5zvRZcwzOx2xtT976J3T3iKaqsnv0T8frSC/LiYBtcp65+eV9QNKeZdj6Fu58ulRJ
         zL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761065263; x=1761670063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OT9BDqZbtTZ8FlPJwy4YL51bMKIbhKLdUmKCp9QkH1I=;
        b=fOlEMlfvE6eeT7xGzoj2rNrUFL/eCWykOUznJ2f+OmSVssxc6W1bNZ7zM4rs2/pGSH
         HrLwcx8swyr52jC7rP1vuFzVzbhSyOoqWLwt86gwHLTC+mrAYraT2adK4HiM1b6Zj4NW
         WoDNc9kuwMdJ5Sq2D6HuzEAtvloYjEJMXjaqx+ED39tbYT0FfwI37cbASj0PyHP0synw
         CpKKFiXcxRzZ4Jg6+k0U3kDXa4leJmvcnkA6brIFBeSrdtVYKJpNh3G4ty9Jdg2EQFo+
         /Wn0Rfwf3DpP9nojRaFuQtf5gbEBDbKsoBq7jElYsuUXyDDlKRnJqn2GraNOyXGq1Rww
         aRXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfArXgFfo4LCNrnAtEZEuT5ydaYZ/GbDkQ3DOBZp+0X3n6Rg0OT1YJFE/O6gHo1Gg2I+yvgxZnrOhBSB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIqvl3wnLSDoW7PVmN25zIJyAyL4ZVJIaC9k+u+ixg4CqfcI4X
	zkrz0ghmPvP0g0IxJKSrOHj2VQ4+hVYBZdQ4eLwLcIQaTx5+1oCDCs9B356agqjdqg==
X-Gm-Gg: ASbGncvp1xk4LsLkWEgTU4Tlo7qpd5pkJmhfWX+8NgDUpD/R9SMoUhISEE4/KLkdL0r
	xul5LUgngclAKYgBbb5fNrhKY9zQJkitCJxO9cIco1KPutz7maUNG/BPZeou4aYqEbZTkArb37b
	m+v7fwrdPzx32pg2hAiWiulKT3uQC6HhufFPc5freO4axWgpYuo4jMeaKhlBprAniF642gI/Hj6
	LVi4KrcWCO4BOeeEADZOSt53+xRX+SEKs6SCNPlvxos5Vaxf3OaxBmK6NRG9VbUoiUnph3u8KMC
	xR/8fzPQ6bG3dswpSqF5Qm9DfRNYOoOo/74tciRV2UCmCsGp3/bbhU4+IV932BKrw5VXmX2IiCF
	/SfLFZP++Rn3ckY3mn+zQ60jVFbebAZpl7eOWm7losUYZQOODSK9X5Nr/7/Lvu0fQ18ozaaxBO2
	SzFjCdRegRqTarH/NUrSKsNfyebfNLBxlYRtLcXb0Rx3c=
X-Google-Smtp-Source: AGHT+IGansT+A0rkfAhKvQNOk21vPK7u8dZSK91Dy5X88gGuQfgY22M2jXK6HVEdK0aJoNY/t4sDOg==
X-Received: by 2002:a17:902:ce12:b0:271:479d:3de2 with SMTP id d9443c01a7336-290c9ca2a4bmr199750875ad.13.1761065262494;
        Tue, 21 Oct 2025 09:47:42 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:ef0c:c990:b2a8:9da9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ec0847sm114116915ad.22.2025.10.21.09.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 09:47:42 -0700 (PDT)
Date: Tue, 21 Oct 2025 09:47:36 -0700
From: Ryan Neph <ryanneph@google.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: David Laight <david.laight.linux@gmail.com>, 
	Lucas De Marchi <lucas.demarchi@intel.com>, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/xe/configfs: fix clang warnings for missing
 parameter name
Message-ID: <qgugikjwzoc2ia7no5x5jspgu6dx6p6yeuhpxkqfsdggxtk5ty@ptmw53oycmnk>
References: <20251017-rn-cfi-v1-0-bf66e6ad4fcd@google.com>
 <20251017-rn-cfi-v1-2-bf66e6ad4fcd@google.com>
 <20251020110513.48d18788@pumpkin>
 <20251021063957.GA757076@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021063957.GA757076@ax162>

On Tue, Oct 21, 2025 at 08:39:57AM +0200, Nathan Chancellor wrote:
> On Mon, Oct 20, 2025 at 11:05:13AM +0100, David Laight wrote:
> > On Fri, 17 Oct 2025 12:46:26 -0700
> > Ryan Neph <ryanneph@google.com> wrote:
> > 
> > > Fixes warning from clang-17 that look like:
> > > 
> > > drivers/gpu/drm/xe/xe_configfs.h:35:97: error: omitting the parameter name in a function definition is a C2x extension [-Werror,-Wc2x-extensions]
> > >    35 | static inline u32 xe_configfs_get_ctx_restore_post_bb(struct pci_dev *pdev, enum xe_engine_class,
> > 
> > Why did that become invalid?
> > It has pretty much always been used - and can be used to avoid -Wshadow warnings.
> > This looks like a clang bug.
> > And you'd want a specific -W 'knob' for it as well.
> > 
> > At a guess the C2x extension lets the name be omitted in the function body for
> > an unused parameter (the same as C++).
> > I think that is the 'definition' and the ones being changed here are the 'declaration'.
> > But I might be wrong.
> 
> I don't think you read the patch clearly enough. Both declarations and
> 'static inline' definitions are being updated in this patch, likely for
> consistency rather than necessity (but the commit message could call
> this out). I don't see how there is a clang bug here.

Correct. The warning is generated for the stub definitions on the false branch of the
`#if IS_ENABLED(CONFIG_CONFIGFS_FS)`.

The pure declarations on the true side of the branch don't need a named variable but I included them for
consistency. I can mention this in the commit message for v2 if desired.

> 
> > > 
> > > Signed-off-by: Ryan Neph <ryanneph@google.com>
> > > ---
> > >  drivers/gpu/drm/xe/xe_configfs.h | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/xe/xe_configfs.h b/drivers/gpu/drm/xe/xe_configfs.h
> > > index fed57be0b90e146d57d966bab0e55e1723513997..a0d614b37efd54b89390f04a238aef1a8d4df4e2 100644
> > > --- a/drivers/gpu/drm/xe/xe_configfs.h
> > > +++ b/drivers/gpu/drm/xe/xe_configfs.h
> > > @@ -21,9 +21,9 @@ bool xe_configfs_primary_gt_allowed(struct pci_dev *pdev);
> > >  bool xe_configfs_media_gt_allowed(struct pci_dev *pdev);
> > >  u64 xe_configfs_get_engines_allowed(struct pci_dev *pdev);
> > >  bool xe_configfs_get_psmi_enabled(struct pci_dev *pdev);
> > > -u32 xe_configfs_get_ctx_restore_mid_bb(struct pci_dev *pdev, enum xe_engine_class,
> > > +u32 xe_configfs_get_ctx_restore_mid_bb(struct pci_dev *pdev, enum xe_engine_class class,
> > >  				       const u32 **cs);
> > > -u32 xe_configfs_get_ctx_restore_post_bb(struct pci_dev *pdev, enum xe_engine_class,
> > > +u32 xe_configfs_get_ctx_restore_post_bb(struct pci_dev *pdev, enum xe_engine_class class,
> > >  					const u32 **cs);
> > >  #ifdef CONFIG_PCI_IOV
> > >  unsigned int xe_configfs_get_max_vfs(struct pci_dev *pdev);
> > > @@ -37,9 +37,11 @@ static inline bool xe_configfs_primary_gt_allowed(struct pci_dev *pdev) { return
> > >  static inline bool xe_configfs_media_gt_allowed(struct pci_dev *pdev) { return true; }
> > >  static inline u64 xe_configfs_get_engines_allowed(struct pci_dev *pdev) { return U64_MAX; }
> > >  static inline bool xe_configfs_get_psmi_enabled(struct pci_dev *pdev) { return false; }
> > > -static inline u32 xe_configfs_get_ctx_restore_mid_bb(struct pci_dev *pdev, enum xe_engine_class,
> > > +static inline u32 xe_configfs_get_ctx_restore_mid_bb(struct pci_dev *pdev,
> > > +						     enum xe_engine_class class,
> > >  						     const u32 **cs) { return 0; }
> > > -static inline u32 xe_configfs_get_ctx_restore_post_bb(struct pci_dev *pdev, enum xe_engine_class,
> > > +static inline u32 xe_configfs_get_ctx_restore_post_bb(struct pci_dev *pdev,
> > > +						      enum xe_engine_class class,
> > >  						      const u32 **cs) { return 0; }
> > >  static inline unsigned int xe_configfs_get_max_vfs(struct pci_dev *pdev) { return UINT_MAX; }
> > >  #endif
> > > 
> > 

