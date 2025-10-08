Return-Path: <linux-kernel+bounces-845585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F064BC56EB
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 16:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99F88189C9E6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 14:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FCD2EB868;
	Wed,  8 Oct 2025 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOuYBZT1"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BABF279DCD
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759933700; cv=none; b=azirdLQC4YIpSGfmz8bKNiEVLAM8DoUVlcNGvF0SJLEgnTNVk8asKCoYLelsNjOsx94KG2GjtrXyJpNczIbh3bP2pHxEnPmUgzPQISuqRPzT4p+dNmTLfi7kE/I5P0Lh6rJxV2NgbQC0gXbfA8GT/clrWk6+G3xeE7Wy98Cb4ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759933700; c=relaxed/simple;
	bh=npeNAX2mCK+rMgur8NO9qYg1axnlP5BBo0aD7CnTOqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tks0Bow2NXHXSrI1qlQEOxFLab+a28PYF+meUMV8afpWXGxg51KsVWE24WtTCLV/QlSNxvAuxvzXOdNAoBvoHt3UMcMZOZpccwlbE5ltCKI8WGPNpMvyc1HnEdkMMpwBRxA08MeyfGUKloDWzXTblsXpsIvK5wIkmgDKQLAPiGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOuYBZT1; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-7900f7f4ba9so72564116d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 07:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759933698; x=1760538498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C3nyMQNps0AyLL97xzttuk+phB0DdoZh7JjDzOjB4po=;
        b=nOuYBZT10rtSjCIA3eSb2fQbRuCk5nauQ44yq+9ziXhPdkvKKN3xaK1J0EqWelvcr8
         23asps50SsoDCyfXolqp1sf8M3j5tV5t0DyzDtnwxAMI86y6fSqa9LqD2TwMp2rO7lDm
         5VyhNA7K5KoRYoQh0VP6IJUE4Uua0FoKVjWs0dUtD5USmqFdNIsGaJOYudVI6OJSzaan
         z4wId0Zs8NfDp5Ab9ncZrxUGphvuiW8O8rL8N08KFB02LofKJdpfOZFNgaV+GAGIeRx2
         qMfZyYhgpQ0ZPNSibf+77xpUKdhPnrh4d91cUQ18kSQgydJIuhoazapGs2bqNejnbPd8
         +i0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759933698; x=1760538498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3nyMQNps0AyLL97xzttuk+phB0DdoZh7JjDzOjB4po=;
        b=nfDy4kibeJR4/+jS5zBrySD2Ddu+kQf3eVBGBaWrfX6KgFksXSZCcTIMFNdyfpCxgQ
         TkecBTkeDRFty3+80sAO75HEvQxvwjNcLpov6+797luq3J1qOiMcAQCNZ/Le0G43B4W8
         RN/B/yhJ+lr3HeWd/LyR5YYl1aLm0a2Hz4brGlNFbxm8/3nrVy/If6AQQXWbst6CRz6P
         clfliQjA0s81B3xrSdrFkA5ObtLfQSN87OJm8pEBBaK+SIFSoz9ERm59fM5pd/wuhQyD
         m+BC9SzMUL1fBaKrmEoRIHCm989CBY+eyv/hyBzUQske5OulvBfcBtX7w9M4mDEhz5Nz
         8zfw==
X-Forwarded-Encrypted: i=1; AJvYcCVADzbQWEu6/DZNuNT/u4uiLlyJpEgbc9iwH/awt32nQuDL6X0AvcT3ENzXlf8knP8OvmiauIb7Y4Ge6Q0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvz6znbnuGUHozCV6kWfDC0MdAPqLvwyfoWXiXpSylSS6Pq4Va
	a+21Yj3LHo3NFyJDRXU6O2TK/gbQrQBhzk61RU7fuSROJzVgVP4iVDq7wTiOVg==
X-Gm-Gg: ASbGncshyVBXI/ZbCU2M77b4Q2133nzh9Ku+yvnJuwBCmDDsFd1Wme75GToEF4VQnpM
	JLFnky9YFvfbKWxAFetiENFNIIFyY4Vsnop+nF0g/qsYBk4/AlRDpaxbZzWIzH9FFD6XOnTBbe5
	qw+kfkuR89isPcWsZbFWMXgTeXNgiBC9Xry40cTHe9+cYUj2YpeymbbyGMyMF/urQML1r3rie3l
	GAxfiqmgkfGHD9zG/y+dlojlwG67heYhoe8cRpHjcQw7cE+QHKeCGgg08k6BMzUoZEV2QPq/Ypr
	8lhvVblggYMLtzZB0A36QF73bsmEtDJP+6u++kiTBQXClmFiNf6CXojkpeUHEhhEkWrPeqdXl5R
	UWBOrEcL2Vr3cNs35Yf4OlMSAprLGzfaNgzyOL1KJ8OI=
X-Google-Smtp-Source: AGHT+IFntZefp3Ss0mi+6jECEAXuwb7eOj/bzue7nh8gRQKVbgbOiMWHYq2oEKWHI2USmbbKcqsDDg==
X-Received: by 2002:a05:6214:2a87:b0:789:d698:d384 with SMTP id 6a1803df08f44-87b2103104bmr48809406d6.20.1759933697907;
        Wed, 08 Oct 2025 07:28:17 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878be61f6bcsm163723216d6.65.2025.10.08.07.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 07:28:17 -0700 (PDT)
Date: Wed, 8 Oct 2025 10:28:15 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Alistair Popple <apopple@nvidia.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	bjorn3_gh@protonmail.com, Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
	joel@joelfernandes.org, Elle Rhumsaa <elle@weathered-steel.dev>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Andrea Righi <arighi@nvidia.com>, nouveau@lists.freedesktop.org
Subject: Re: [PATCH v6 0/5] Introduce bitfield and move register macro to
 rust/kernel/
Message-ID: <aOZ0_7YQw81lyMWt@yury>
References: <20251003154748.1687160-1-joelagnelf@nvidia.com>
 <aORCwckUwZspBMfv@yury>
 <DDC0VAHL5OCP.DROT6CPKE5H5@nvidia.com>
 <DDC49ZIRX79X.2Q4KW0UY7WUF3@kernel.org>
 <faa99188-7ccb-4c7c-b705-3a207f5acd17@nvidia.com>
 <DDCFLM3P5MCC.NEBRVTU7X2G3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDCFLM3P5MCC.NEBRVTU7X2G3@kernel.org>

On Wed, Oct 08, 2025 at 12:08:59AM +0200, Danilo Krummrich wrote:

> Regarding the bitfields for page table management: Are we
> sure that we can use raw bitfields for this?

As per my current understanding we can't. Bitfields are not suitable for
direct I/O and considered as a data storage. In the current scheme:

        regs::NV_PFALCON_FALCON_DMATRFBASE::default()
            .set_base((dma_start >> 8) as u32)
            .write(bar, &E::ID);

we account for endianess in the .write() method, which would be a part
of register API, not bitfields.

FYI: ARM64 is in process of dropping BE, and Linus announced the end
of BE support for RISC-V:

https://lore.kernel.org/all/CAHk-=wgYcOiFvsJzFb+HfB4n6Wj6zM5H5EghUMfpXSCzyQVSfA@mail.gmail.com/

Thanks,
Yury

