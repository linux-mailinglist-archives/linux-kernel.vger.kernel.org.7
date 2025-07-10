Return-Path: <linux-kernel+bounces-726150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13432B008CA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674E61CA11A7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FFB2F0C51;
	Thu, 10 Jul 2025 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASr+D8vW"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B067F2F0031;
	Thu, 10 Jul 2025 16:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752165027; cv=none; b=MSjMGQIGX61t3RvUzRE4b3uj3QO7GPYK4TzTcYuee6zqnt/39xpw3t9yqJ249pGbhe+WVrgm0+WT2P/vF4zDFO7gOhsJKRtWY5OFA7SXyp02VBjVoXUUtTdXY2ymWBucUt07S/P61YYmngbrS+rLesGm8l36TbIsBf38Gxx/J4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752165027; c=relaxed/simple;
	bh=dXEx8C4zdMhNe5T9SlUrwVutUxjfS1FZbZI+sOaRdN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDkkVKoR+iJUpCGSqLgHqN2Cay/d5qsShiALjPY/43x3u+aiaDo+qPBR8l4zVX56rKQAT/TiVogLdCBtdF8b2YMeIan0T/g80+Yfc/P4nc8zFSSofWOtFEsCl2b3uMaeX9LMBSAVE5XIz7qxRYFSw9soJHcpYF7br0oZy+4HaFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASr+D8vW; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6fb1be9ba89so11823656d6.2;
        Thu, 10 Jul 2025 09:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752165024; x=1752769824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZgmAU4thp0bHztOR8076veA3tx3tbvAjmteD5mC51w=;
        b=ASr+D8vWtmmSJNM/fQLCQbPcRwj8Q9eDVt6bkkhnTpog5HZFzFBOZ9MCtxbGwxyjY+
         MozE9IxqWBEiMGDGI9GLTpK87GMmLBHINYlvL3PPNzfnBsKvRghnbhNHuhNKPlRcQSNR
         E7yJDVpjRf9ROELeicFN2obhsZvxJic4S1aQxqY/QU/Nx8YIz6iHgu1UatzXhMHlVzfI
         +6xa2wURwJHxQdsreJB01QsxBe9y8sK06o/b5l1qTmfx0vA6wFLGmJI0qmfoR4h0XvhL
         oU0LPSJ5MdwKztWiYijVr4Q8yFHPZwoSx4Hj1Gfd9tGBaj+eQ4RvlAzjb3IeEXJbN7x1
         ANtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752165024; x=1752769824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZgmAU4thp0bHztOR8076veA3tx3tbvAjmteD5mC51w=;
        b=adNROcD8kFRC7qvZbZB1/L1jBBFOXZSB5wgDsd0IkQd9ZTNURHM43vi/wjgUL3Lepl
         FG9tiQ7RPvVy8XCqRBbsV22FC2MnJzwWPJLViJNVUO7l9w1x9T/b17FPfJbT7Grr6oAS
         r8hOSLMoPAl8nDWZeVw2sn0h4GHSgNgEGz1si8kfhfnOo0ywsTJcPXV74xAPZqxcO0cN
         JJD58uya3LZGo3SWgk3DezIEcmRbXrl5MxE0fciIaZvVNVYwR49j1IszbUT6eZduP+Y1
         hOffan8IBrh4LDUfE1FXtwcCKufglZ1VVop3W5KzviMJZ8baQxEM+g+Y9uWo3b4oCvLQ
         oYYw==
X-Forwarded-Encrypted: i=1; AJvYcCWTbQ49KHZTs77FYn/DEyR5VRDZKWtyuPZgbPobb4aQRszyXyOXIUbx8wVrkBPRPxfgjEC/Swr4aP57T7M=@vger.kernel.org, AJvYcCX2Umo4gWe+V3HqtIhEcv6iI+MiTScnbWY6Wkt9qZW1k8nig+Y5FH7l9JijJ1cjPPGyolZyC1AOLpwBVrR74Zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YziPSh166E2NSrLxmDK01BxLDtYQbNLD3Lgbmh5Y3CKE411V9i3
	v8sZGoZCmE8ziIGgvTZIiStqdUhX06TQYv+lEZUgN5BbcHxN43yFxEr9
X-Gm-Gg: ASbGnct7PlgUdaUWjtQxGj1XyP/t4uX0KdI3FOLblH4ozQ2AnTzwPN4sfARfF32N92I
	SKebYLA1Zz2kLo4IIwfPqldkRqzbEpapY1SJhkdHbWIvlL71CjcFswWyTlKd7Uh3Hh0/DBCX3wR
	j49tEyYB6Yzfr7QQZ0VkGTCH3Idpilh8sXiLuGDAzrVK5v9vHWUWgtZZunSCkhqBiZqE/nD9qPd
	nNiMan4yBNDjPv+VcWOlmqm3p1XT2mNBkxTjKvTmHg6M/JthxmsKS5ceBOJMv30XZWrASPrgV7F
	iayapy+DyzlbMr9yXC+2IsvvjQOYEFw0QLKWeLJB5JKfG8Jrfa4gXMgo0cHQMRfej0UdeFdLXd0
	py2Q+BRwmQjrl+14X46PS6Js8PsFOzhDAKUbJG9JArye66bFeA1ScNCq6nW1AYBg=
X-Google-Smtp-Source: AGHT+IH44LgXLQeB0ubyR4yUU2OUERWsV2U+tjNpfzw60bECm7IdvvtdKDYi+L38Ia2m2UuV3Yxxcw==
X-Received: by 2002:a05:6214:226a:b0:704:84de:9640 with SMTP id 6a1803df08f44-704a34044a4mr427646d6.18.1752165023556;
        Thu, 10 Jul 2025 09:30:23 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497db4acbsm9894686d6.109.2025.07.10.09.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:30:23 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8A170F4006A;
	Thu, 10 Jul 2025 12:30:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 10 Jul 2025 12:30:22 -0400
X-ME-Sender: <xms:nupvaKJbFnonf-W1cZ-YRR3wFhrIC6kq6b1p2WshFO2Kxqdg5_Eq1w>
    <xme:nupvaKCa2yEVGWxBxhLVtBYs7AfoSxjZf31qgx0gPdAeMKhY-MOYz0gKvheWwaE-E
    WIW3MiLnKOgS7Yjag>
X-ME-Received: <xmr:nupvaKH1n7ZsjqEM5GyICTA4w1fO6DLrKRTdRAKy0rxhsxJajQY0rKYUfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegtdelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepthhjse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epjhhirghnghhshhgrnhhlrghisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhih
    sehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtoh
    hnmhgrihhlrdgtohhmpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehtmhhgrhhoshhssehumhhitghhrdgvughu
X-ME-Proxy: <xmx:nupvaHLDh5sk4sxAWD4fc4EJHIYcwPajsAalAt29uyqq76v3zXy5xA>
    <xmx:nupvaJrhBBss2oTmhNinMTaiZkZuQTEbYWqco2m9xV_6vaZR7Cm_DA>
    <xmx:nupvaGiGuN8j07MvPJkjTVlKqLywmunlVovm3AcyAHqSwOTesdsluA>
    <xmx:nupvaAb2mPORQYmlwoEdLC_cFvd7bNkltnzk_Fy5jyCBqWUquSkS4g>
    <xmx:nupvaGlisfYrgowJzi02oMhFi9tnSB11eKlmcTJpbozlxRpn_6ecyYVx>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 12:30:21 -0400 (EDT)
Date: Thu, 10 Jul 2025 09:30:21 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Tejun Heo <tj@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, Benno Lossin <lossin@kernel.org>
Subject: Re: [PATCH v2] workqueue: rust: add delayed work items
Message-ID: <aG_qnYSu4DU5xnP1@Mac.home>
References: <20250627-workqueue-delay-v2-1-84b046fdb4fc@google.com>
 <aF7YWE4bz98Gqh1y@tardis.local>
 <aG-7402hh4CCN7vh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG-7402hh4CCN7vh@google.com>

On Thu, Jul 10, 2025 at 01:10:59PM +0000, Alice Ryhl wrote:
[...]
> > 
> > 
> >     unsafe { Opaque::cast_from(&raw const (*ptr).dwork) };
> > 
> > > +        // SAFETY: The caller promises that the pointer is aligned and not dangling.
> > > +        let wrk: *mut bindings::work_struct = unsafe { core::ptr::addr_of_mut!((*dw).work) };
> > 
> > Ditto.
> 
> The rest of the file still uses addr_of!. I think we should stay
> consistent. We can update the entire file in one go.
> 

Sounds good. Thanks!

Regards,
Boqun

> Alice

