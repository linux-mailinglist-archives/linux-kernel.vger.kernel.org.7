Return-Path: <linux-kernel+bounces-737303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD271B0AA83
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 21:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9546C7B27F9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 19:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCA92E7197;
	Fri, 18 Jul 2025 19:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8H+E9Jr"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F111BD9CE;
	Fri, 18 Jul 2025 19:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752865509; cv=none; b=fUrDkJ6p9t72eo6fmbG7WeqZBP8m/XAvb85Cj6K5yZ8Y45OfozZGntCX8WwqeU1ApIhByx5ga9RgR3yIEizt37S6zI9cXoLvJQ0Pu+bIe3QuXvYpugrwbLsPBa4JR01+ZrQkiGOv0PqGkgchb4L9tnH0wbgSuaRXq8HRwgQwIhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752865509; c=relaxed/simple;
	bh=NBY/QIqmyBqwXj17OHad7123qq453xR4e4DzHxK31IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cy1sLyIffXy/1KmTjqIwHlJd8NHPyjulMpgAKfnQ4jA1ghEpcoLKl1ysg4p2St9dgWcKkq3c0i0vCF9eVMs7ZDbXsst538a1FWY+hi4NAPlpv7KGH6uocKxrp+N8jgT+U5O33wz+von1ISKHpY+CKwVU3/73XWQqVPMFHV+7ioQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8H+E9Jr; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7e32c95778aso128344385a.3;
        Fri, 18 Jul 2025 12:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752865507; x=1753470307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5j79F8WX6g4zI7dhSEPRiOOy0m3FlFhAAbp2BrZjtaQ=;
        b=A8H+E9JrxOBSKi5FaJO89JJ9kKTP/05fSqjrQEjjrbST+nL69M9pFLX1WVYVQXtbrZ
         2bec4VyvOGwPZKYgoIf9rn33r9vEiPS3cBfC2bjzEuXVoc73QN3Rb8HwBPHlfrl/Tdz5
         02uo388Hlg+P4X2+sEFC/4FaFWBpv1nnfICwh9Xgks9o81RcFQPAsO6zxt83+oVT1yqG
         YiHYq5bA2owPl1EFgRQ9EcwuEVVTfCz1Yasz1i8yqaOulpo0afhcjdLMeMi0MA2YUOG0
         l7lEi59z1K0ZguisGwuNNJizAVczJReGw0/om88QbktnPuN0xjn4RewraQTKKheTFPOR
         /RQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752865507; x=1753470307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5j79F8WX6g4zI7dhSEPRiOOy0m3FlFhAAbp2BrZjtaQ=;
        b=lPApErIMGAg0dvdmUPTouEZt+a/IxFG4mTGLrswrSH2XI6cdqlLIzrlqAyL9kk6jgC
         20k29eAMf/yxL5ReL/LuHc1uQQqqmvCcRsXmGcqnMSdSdY3LYtLB7v0ltI+YRcQoBFIb
         NBdbK2YhEqbPCWEXpUrQrYH5v3rG8c+bBaoeUUqPofZk01m9dXe2jWfcxA3o1tD4yXU2
         FhdFpQsOX8pS/iKrmdxAUIZom1fBicFif7A5b4kO70jaUDrpeumlMuFzD0Sr4PzO6zNV
         ntC3l0mSEg4fj2Cw1tg25MshZcpAOruU3SkEl6s5LD8Gj3eTo5vqPj8o9dRsX8IUT2Bc
         YY3g==
X-Forwarded-Encrypted: i=1; AJvYcCU5/4u9DyW2mUuW2H60pgej6is8Hb9RCyMPesZmszugD6iF9eGrQr3kBgHfJyTvfyE5FWUqQz7fpWLj9IjRcWM=@vger.kernel.org, AJvYcCVzkEI2j9YoluKwAmVU33ypqxaEZp9nI4GLtBAEeqCzDouptrXVdqTnNFu4+tPXSXcV/7kVT0oylrX/SOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK9EQjwkHLcSWr9itHqZYOWG4tPU+st7zyI6zKREjh77mx7sSU
	OphapSxcb9pLs2UONGj8La6hNioI0UR2aWlvfdXWpF6IU0BFMgjzYz6X
X-Gm-Gg: ASbGncsNZl0KcPObNCv4sJek0fSGn/N1LAJ4SyOAW7G99YdxuQpABM4m0AWPWpI1wQ1
	4lfxGAuZ3uKGJhybqSW0ffEgWY+WA0MJzBgWO5lIibbpF/SpJnQTUUaWJghXoNuLBshOhhnyC4x
	S35dx1adqStVHrsqPzUgb4svl6EfNE+hidkxecEQueZg+qnMlVhT53YemPTZ0v1Rt7qg46muQv8
	7rR7q1vb1qxFHoG3DD+8Wawbz7HXXfvDfEonF74EGGykcSX0bMzt/Ne96G32+voEICeEmspi2Ev
	+bU9Cl2mnzKQPYBhMTNkyGVbVea1P1N9C2WUoXNUQur++KJzwyJwKBOnuI6GCZE/UZf/uafrYbU
	j7xSWpATBB4Yvm+r47EazdGrbbF5PLTcPztwITMK4mS62kSjMIOsKePqDhAh2HmtoaIa7tR+XTc
	+oVrX3jvgmXcxFcSKt9mNL2WpekuYyyrgctA==
X-Google-Smtp-Source: AGHT+IHH/NifKTKz2dbR90WbWGGqf2VV3ZDVe1t3kE2kVXHFT8QLOk9feQkrf4IyGuzEzg2JakRnyA==
X-Received: by 2002:a05:620a:2811:b0:7e0:9977:a803 with SMTP id af79cd13be357-7e34363599dmr1583267185a.54.1752865506723;
        Fri, 18 Jul 2025 12:05:06 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356b62e63sm120881285a.47.2025.07.18.12.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 12:05:05 -0700 (PDT)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3B879F40070;
	Fri, 18 Jul 2025 15:05:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 18 Jul 2025 15:05:03 -0400
X-ME-Sender: <xms:35p6aKs_0L9U1v9PEKDAHghrb8pBMTy6Y_CSJVs2sxTVoTEhmG7DLA>
    <xme:35p6aLRdSW2XmEFlD9KxPuMSpgDYq67TpE8rivNKbQkE9g74EEG_frD4xNPenvUGl
    2Fei3aKqk913i14VQ>
X-ME-Received: <xmr:35p6aMPBwwc2QfgaCuu05VCiZPH9ydnYVNS_PW32DK9zsQg9Vu3wS2k--Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeigedvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheprggtohhurhgsohhtsehnvhhiughirgdrtghomhdprhgtphhtthhopegurghkrh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtgho
    mhdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtohepmhgrrg
    hrthgvnhdrlhgrnhhkhhhorhhstheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphht
    thhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtiihimhhmvg
    hrmhgrnhhnsehsuhhsvgdruggvpdhrtghpthhtohepuggrnhhivghlrdgrlhhmvghiuggr
    segtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohepsggvrghtrgdrmhhitghhrghlsh
    hkrgesrghrmhdrtghomh
X-ME-Proxy: <xmx:35p6aB63XXyz8ju8xf2icVscA4L8vXiK6DrLQCcWzQsJgW3hZrYU2g>
    <xmx:35p6aPVevi0ooEtaSNsSsdGrEIwePW1wWUAKNqsrfQDxpeWaSX1OZw>
    <xmx:35p6aIP8HeSkU_tBsNcNzqWa9DUz1ZWFcxmvajorjI32IYqAaDLb2g>
    <xmx:35p6aGgF-Moe335sqLuvWFUTe7_TofctfCedLXnMpuZiXJu9Uckhcw>
    <xmx:35p6aO7HAIcMVeE7dESfP_QlvJHWJshyCbdI6rYJuOmvCkWz2WFBH-JW>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jul 2025 15:05:02 -0400 (EDT)
Date: Fri, 18 Jul 2025 12:05:00 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Beata Michalska <beata.michalska@arm.com>,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/19] gpu: nova-core: register: fix typo
Message-ID: <aHqa3HVUjIC7zHAr@tardis.local>
References: <20250718-nova-regs-v2-0-7b6a762aa1cd@nvidia.com>
 <20250718-nova-regs-v2-2-7b6a762aa1cd@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718-nova-regs-v2-2-7b6a762aa1cd@nvidia.com>

On Fri, Jul 18, 2025 at 04:26:07PM +0900, Alexandre Courbot wrote:
> A space was missing between arguments in this invocation.
> 

It's obvious up to driver and Nova folks, but I feel this commit better
folded into another patch or we make the title a bit more clear, say:

gpu: nova-core: register: add the missing space in register!()

Otherwise my fear is we're going to end up with a few "fix typo" commits
in the future.

Anyway

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/gpu/nova-core/regs/macros.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/nova-core/regs/macros.rs b/drivers/gpu/nova-core/regs/macros.rs
> index 864d1e83bed2979f5661e038f4c9fd87d33f69a7..93e9055d5ebd5f78ea534aafd44d884da0fce345 100644
> --- a/drivers/gpu/nova-core/regs/macros.rs
> +++ b/drivers/gpu/nova-core/regs/macros.rs
> @@ -116,7 +116,7 @@ macro_rules! register {
>      ) => {
>          register!(@common $name @ $offset $(, $comment)?);
>          register!(@field_accessors $name { $($fields)* });
> -        register!(@io$name @ + $offset);
> +        register!(@io $name @ + $offset);
>      };
>  
>      // Creates a alias register of relative offset register `alias` with its own fields.
> 
> -- 
> 2.50.1
> 
> 

