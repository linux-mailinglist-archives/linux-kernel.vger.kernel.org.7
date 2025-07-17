Return-Path: <linux-kernel+bounces-735607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CED3BB09180
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FC66188803D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210BE2FA62F;
	Thu, 17 Jul 2025 16:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHRei6ps"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E68288C12;
	Thu, 17 Jul 2025 16:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752768861; cv=none; b=Y8B5r8faTZDkc7LnsqCnEHeynm2V/jsnvjec/7fYOwerB5e3d0lMNsYs2Q9xr7n6sDtTRN76eoAlVOFGYNsRUabp+gUlqGoxkXWpqMzwEW/9dXHHX3+jw7SkYHXr2GvDsBSxB/UMXSrjpXiXh0TnePvnEXNtziUh86iLYUQxUYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752768861; c=relaxed/simple;
	bh=/P/sV+sQCJwwTH0lx/U38MZ3P+zHFO7z6yDbHcy0kNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/xkWyH17fstiOnjlhhEmvCDUnLKUbOR7gJWpFhs2W5abKdx5GdnuaofgOhCWk8sVFpIIq3LhlGSVdDxXb17WNt//LAmUnacNjOAXbYGr/jvIIgGFemJVWbDlac8m+hU3sAs/ZCumGclmttRStt5bOAVrb3Z0KSR78DCj3sS1n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHRei6ps; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6facc3b9559so15369916d6.0;
        Thu, 17 Jul 2025 09:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752768859; x=1753373659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+yz+W/V56qlFCu6Ortl7e+6CnAcr0ty8ni1aHJ/G24=;
        b=aHRei6psRIS6wK/YPANELOJz8d9aWwSfHDqZqPi2V9W7IqBrWXekZxera6oogrOxCP
         5U25mfgLd0Q5LY+NbaXJQGBueQ4/dkC6Ht9QbKTEf5sf17PJjPuShd6nlkwOSKKjAwqW
         rDZuYt1SKPfATkCqha+vZ7mB4V3+0rkhwRCVUhlMYZDC+vPmcZx9dj0bgjuL7zckyNdf
         BqwRnoSuCuHEBzKIwqL4hQ0+1LMGx3jSheQnrmoinhoXgOEZX0EwB1vOqOaSGs95NoCX
         XP/YSqGXS0EcSuDDbtMO7nWNnZ2ooyYITxB+92sp//DBO7LjZVTLkUhZ27XEzapr2VoE
         YYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752768859; x=1753373659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+yz+W/V56qlFCu6Ortl7e+6CnAcr0ty8ni1aHJ/G24=;
        b=aMbJm8e+ojhIiKE1aZCgt9O2b0rwb5kBbp/TfVkoAmP4vnEeDitpL/J/2FcgMOaEyS
         GnRTJ3d8NAT7dnMm4yemAFjK1dOh+pdacT9tChbAdyjlBKLHfe8ZpCnKnZveJyoHsQb2
         FAOxkJ/kGWzvYBpkqGMRMOvbmjspqCn9yxHEO3RdrGjanbLB+uwDVx0WchQx2vcYC/49
         Wii9SQmuDfFvU9sS1QO8ElGsVHHn4hZkzmOx+fzicqsvaEAPBBIZK0svliWwz0/7W3Hx
         7bScmyDOxSyXtft//C1ZuoVLZbG5J+nd1APD+sVokFC8yieg8vPYrvaUaLFLcZYlo5H6
         25VA==
X-Forwarded-Encrypted: i=1; AJvYcCWreoY41/R5Q5y1WcyrhBe4KM908xDYCzbrjZ/racnB1137Pt7IsCj5w38P8cSd+Tw47nnqUGSXFqyoVbI=@vger.kernel.org, AJvYcCXrgmMhwx8BCXpRG1Lf9RP0K2X+RN4RuNsx97EkpPjoUxPCms3wrgwyHTEDiYVVjAj5zbCbIiGTa6QIOD54Fl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpHWU7lI+wFfy2EzBieQwdsYxOsvv6Lcqmkpvgu37aIL2qv5wl
	IagNKdp2z3a+LyCMbfs3Smr+i+opCdoRc8khyZX8iEsextaEU6nH3LdX
X-Gm-Gg: ASbGncsVoeHQXbrwac354GQTDxLoOluzyrhvjenEaXhf+aGuVpiw8YWtbS83c3DQ3Mw
	WQOol55vPF1xo8zTJLh7oMs71FxhVAj1MhgjrijmrzG8HJkumQQUDpWGti4oPn2DVAtVRiQ2wrP
	gWOfvxha8ANNebKhW6ALBbO2JOqrVhQAO1gY2mEowoKxDK/R6MyMP/6v6hSgs2cr4FrZEpkCPjT
	ymJyyQRcHIh4jRpzo2zgQDlN2dX+1YwgrdUcpX1aG3kgZk0caf7jCKUqhCSrjmNWHHz/21KjTDb
	KtxGPQRy/H2x/63OtjYwGAohsg20yDEjIKy3tLnLjnu1bHESK0mhga9bZKBSxlQtQQIMOErXSNS
	r3TSVpNHZ8MeQA5nknHBhMuFWjaELXokGITGXEALz3CEjgg8shZK/qsD5G7FotFEt68amy9+8KA
	jyODkMnc5XbWqG
X-Google-Smtp-Source: AGHT+IGPXNss7QM/3gt8EaNhAyoHgBwLz/cvFQg+KILkOzEQ9CC5cn74rJSv6rbv4jcqqkFdPVow4g==
X-Received: by 2002:ad4:4ee1:0:b0:702:d0e6:6e6b with SMTP id 6a1803df08f44-704f6bfd432mr111820616d6.45.1752768858643;
        Thu, 17 Jul 2025 09:14:18 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d39d14sm86256086d6.76.2025.07.17.09.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 09:14:18 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 50D6CF40068;
	Thu, 17 Jul 2025 12:14:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 17 Jul 2025 12:14:17 -0400
X-ME-Sender: <xms:WSF5aBq0IeXzv2Yh02VaaWVgfcxo6yej423YJ7xjyZo4iAjVdUhgDg>
    <xme:WSF5aHnK1wY0eaadXUvWS-EEn3eOMQoO049h5pLab7DXztVWHZOM_YEu39sIXU-Pz
    mH9HgtH_kuI2rm9rg>
X-ME-Received: <xmr:WSF5aCyiTGOTpDGgCzV20ONDcDVASJ7hh8CnFMjLjc5sEWVCnTQ6iYHgYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeiuddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhuhhirdiihhhuse
    hlihhnuhigrdguvghvpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhope
    hgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehp
    rhhothhonhhmrghilhdrtghomhdprhgtphhtthhopehlohhsshhinheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:WSF5aE2eit8GwdcxDzZsIkWPPFN4DKRNHoYnoO-mSWt9xU9axqthLA>
    <xmx:WSF5aGDyHYJAW1kNxzJ6djBb2o2vI8DssiugjZPNAS9R8vXk9teT8g>
    <xmx:WSF5aB_F8bBhYIC1qj4u4LV7aKfWRaKNyJwNRixVg_kr9qNPZWd4EQ>
    <xmx:WSF5aE8AVU2Ck9YQAes6FLYPb1OgFNeQLDfWiaVUqGV-43FeI7maOw>
    <xmx:WSF5aB0QqzAN9sDKSpgx3UWsOdl1XT7UyqDmQwn4j4NgJe_UlAQ3rsh->
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 12:14:16 -0400 (EDT)
Date: Thu, 17 Jul 2025 09:14:15 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Hui Zhu <hui.zhu@linux.dev>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	bjorn3_gh@protonmail.com, Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Hui Zhu <zhuhui@kylinos.cn>, Geliang Tang <geliang@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH v2] rust: add a sample alloc usage
Message-ID: <aHkhVwD7WKm1dSsa@Mac.home>
References: <20250717095053.49239-1-hui.zhu@linux.dev>
 <DBEAFCFHFU35.1IZI3ZSJSIRAY@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBEAFCFHFU35.1IZI3ZSJSIRAY@kernel.org>

On Thu, Jul 17, 2025 at 01:19:05PM +0200, Danilo Krummrich wrote:
> (Cc: Lorenzo, Vlastimil, Liam, Uladzislau)
> 
> On Thu Jul 17, 2025 at 11:50 AM CEST, Hui Zhu wrote:
> > diff --git a/samples/rust/Makefile b/samples/rust/Makefile
> > index bd2faad63b4f..7c3e68d9ada5 100644
> > --- a/samples/rust/Makefile
> > +++ b/samples/rust/Makefile
> > @@ -10,6 +10,7 @@ obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
> >  obj-$(CONFIG_SAMPLE_RUST_DRIVER_FAUX)		+= rust_driver_faux.o
> >  obj-$(CONFIG_SAMPLE_RUST_DRIVER_AUXILIARY)	+= rust_driver_auxiliary.o
> >  obj-$(CONFIG_SAMPLE_RUST_CONFIGFS)		+= rust_configfs.o
> > +obj-$(CONFIG_SAMPLE_RUST_ALLOC)		+= rust_alloc.o
> 
> I think adding an example for large alignment is fine, but let's do this in a
> doc-test on VBox in rust/kernel/alloc/kbox.rs. I think adding a separate module

I would suggest using #[kunit_tests(..)], which is similar to how
doc-test run, for it if we only use it for test purposes.

Regards,
Boqun

> for this is overkill.
> 
> Note that doc-tests are executed on boot if CONFIG_RUST_KERNEL_DOCTESTS=y.
> 
[...]

