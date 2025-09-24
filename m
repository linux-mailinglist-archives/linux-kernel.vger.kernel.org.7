Return-Path: <linux-kernel+bounces-830737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C70B9A6D7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF025381174
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0EC3115A1;
	Wed, 24 Sep 2025 14:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGMXIV9t"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0114A35
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725614; cv=none; b=qRhjD2HgiBlS3SdiQRvrONtxWYFePmiVVMsILSXiv5UxJzacz+ReAnyU/+1pktPJeoC1B/Xis5GEH2m8Qz3QMWGDvxEEdhCOZVCHyyBjFEJeZgXLDpf1vNU0zkS5znZxOjtMoZ3hMZPC6FO41DU24sMWJJeUQB4VX3mu8r9wTuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725614; c=relaxed/simple;
	bh=yM/Q+X92fTlkNYlGxigRsIYhUdkygT31tNqbJqR8rLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ap+tqj69ycROnfW+9BO3t2tI5qPJVg8IhMFkAq4RvCwNlU7WCTcNm8cGauFXt4tohQEt11ct2Btd5+NCykctkbkB0SixGEqf1eVNE00x8aHs5Cq/2Gio6CcssCtSUunuOlmjnB1f7E8QP4p/anrzWopqxJVk/SGlqzQblQ/HA6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGMXIV9t; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b555ed30c1cso1826564a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758725612; x=1759330412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/3NJ6x5Kdp89Akvi+2hnn1AXNw69P1zSYTXvdA/OXZA=;
        b=EGMXIV9tUKUdZlTJ7F6/RmTACuQtSD3XNPEO2xf7cCTaKRIFdsGMsqMgTfpX1GlgX1
         XrvyyfuecHlK/V0Rd5OwOMYOwJTQ2aoCS+TaqyQK1b2wc6leWzSqnwAmBTzTazsoatbg
         o/zF9QBrGQ9CCca/sGOXFP+B7j7SjnTIdokeNXfp+0VbBdfjgdkd+5xURshJPe7qG6dM
         luI2YDyPt7EdDbrS7c/N/psTJ4rf6iKZAq0oxq9IrZROhffIds7euXJigCkjvpj6+YOD
         GhnurF9vgZsfUBdVVVyXjYPnrWzJDwfdORjC8BpdcwGJxvwT8XRbXEkn5+PiuXC2ojD5
         B/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758725612; x=1759330412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/3NJ6x5Kdp89Akvi+2hnn1AXNw69P1zSYTXvdA/OXZA=;
        b=RLM/J93NOpQ+DvaFiAFFwd8SD2qsejOtkYxfDhMCO+F6qdoJEMZg0uJah4dFv2zJ6T
         UiTYBoJCX4rQTi+G5BQTE5Sb530kR3c7vwHsnwoNaSAmPKbj5NUEKzlTefD39fu2d+vD
         +062xuM5ouHPoEGu/FGWr/89QGbZzNP/GhfFPOUJznRQQ3EfwLHVxBpDmYzN+rjNOi2O
         uPREAEfbwAp9oFA02rgnJ9zdxxxGX/gcfAIBxjpliQeZHBrQyfR6k/QDK4A09HziVF+Z
         2SBfeCqZ/YPerrNgV4Lgvuu/RnWXZBTM9J8uSotTg0pfYhHw+jcpQq5M+j6RXmaDhrXY
         hrCg==
X-Forwarded-Encrypted: i=1; AJvYcCV1LP3Z2/LLOYz8bD6BH4ayIQqdjQES4Y77mAvtqX19a1NVALwsC69GiVLjlOjJ3tKnGOHswlhTsL8ShEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6t0K33SP37ssweWZLSM9hoAw0o9Rr1fcVE67aDiwrqMGCc5HO
	aebMhoa2VhH/NgC/zgiAfUXlSBIE1EgQykUXf0YhtR6Oz+58iW7wl+5I
X-Gm-Gg: ASbGncusqAujg19lU49ymPOHpUd5v08Q/4zJ7KxEsovRtIqZCY7c9AKVxTRgS9c1vEZ
	x6A79UEvNY5b3MyMuoWa6vqH568VxUopTNfMjKEbYPGTt0NZm/IbnPIKuhZvIXYNmhKm7Bgq3z0
	FJvTi3BS3siXuDZVh1S42vOocFK2c7Dfl0HAqvZxE3Vk/zD3wsNcj7q9WiwKzFJYjU4ZXTqDk2v
	EXRI4hRmcFk3Rq9/HjK1/shYhB6JTAGEeUEDpTN5UM2KKyr1UePtsPPLJpB8CNXPdMTBog543qK
	HnQ5rb60UoNu0UVvRwBdjPAtggM3HWtyVcGObffDTgf53cZOljWeWF1VFslQHYSuxIorAnwbFg+
	QXnzhsNPfhJZ14/lgOLCuELj7C4zRsUM9GSo=
X-Google-Smtp-Source: AGHT+IHwdBjJXGvCWrYxZfTaJY8CaOaLZ3+d2LVxSNcLp40JjFPUdhB/JhjXkWgZBBL3x2RWHHNt/Q==
X-Received: by 2002:a17:903:3d06:b0:275:7ee4:83bc with SMTP id d9443c01a7336-27ed49b8694mr315435ad.2.1758725611709;
        Wed, 24 Sep 2025 07:53:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26afe6385afsm155848085ad.39.2025.09.24.07.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 07:53:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 24 Sep 2025 07:53:30 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: wenswang@yeah.net
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	jdelvare@suse.com, corbet@lwn.net, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Add MPS mp2925 and mp2929
Message-ID: <03adf64f-e583-4de2-97bc-0a4a9778d5a6@roeck-us.net>
References: <20250918080349.1154140-1-wenswang@yeah.net>
 <20250918080603.1154497-1-wenswang@yeah.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918080603.1154497-1-wenswang@yeah.net>

On Thu, Sep 18, 2025 at 04:06:02PM +0800, wenswang@yeah.net wrote:
> From: Wensheng Wang <wenswang@yeah.net>
> 
> Add support for MPS mp2925 and mp2929 controller.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Wensheng Wang <wenswang@yeah.net>

Applied.

Guenter

