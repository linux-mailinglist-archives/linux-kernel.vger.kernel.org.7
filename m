Return-Path: <linux-kernel+bounces-827923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 355A9B9370C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 00:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E37503A8E44
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCB531194D;
	Mon, 22 Sep 2025 22:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="RLXI2VsT"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5EE2F617C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 22:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758579015; cv=none; b=GwJ3M5GZSD5ZAMPVgRTG9GK91MfDz8EiQD7u6/qL4Ah5EoZFpsjESPJ30K3ii9y9yXd+hMMejOol1p06y+38u+B+F/n/xCYrpBwEqkMxl+xJtzTuCEhL6Sy5A6iS82qejckDeqkNFVUUfHhxBGuKeGlSOeHaXfVNOyIMqm0/A78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758579015; c=relaxed/simple;
	bh=20hNPRoiSo9eeYh2/WqnMMEHn20AD8bo0nWMtUjzCwU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UFBYfaY0Rte6pD+AXjlaV3Qh3hT8irolhGWcNqbwSpxQ9FHuBYuEacYndwV+moQd0TdbVOh22hoBjN6jt8fxpLT2+JaAq152v+QvQGGFutn8mJfd/BujeLUtKOKedPwotnwfBpwRqR8PuwswoqqkrxbAm5/BsBnXgIE4/RgZMj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=RLXI2VsT; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b5eee40cc0so48811541cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758579012; x=1759183812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TGENPXenRny8byjVhYlqWVAobXHkgm90MTEZWLo97eE=;
        b=RLXI2VsTyhxOfaaCJvkVjQtIS9Ae386+qLljTveQahzCCvVfeZece7v9LLkcAIZA5a
         8yMXPVhK8Oni8lTqwzcKz9wJWSJESy+kTPdGfgQz/RcRMp103Bv82RWWmQsY8Icxx+QR
         9P7aoPHNYdAajJ/5gIQWOMrY3yKlKFii4kMkqu08xemGnmEbMe2aPVZQ+FVVbiaF5hHe
         800e+834NaNBdGLtz57GpzZUrPvido1dvh8BtA2R50QfzkJI3UCCW4PK2exxQNGqSiDY
         8JPk6jKnVFLniQd6Er3tk9yul/zFUx9iKkhRA2eCGGb5efjxF09UBgiam7e2B2RurR+1
         zN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758579012; x=1759183812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TGENPXenRny8byjVhYlqWVAobXHkgm90MTEZWLo97eE=;
        b=GHvO6hy842ET+suT76UQ3mSFb2tSO5zcc65RVY7fpJblV7wH0wmrQF+CD9vpr92gkT
         oBSDejnx71+aSl/c+Zj9K/kenMWpJ/DylIf6+rFguxOddHrRMQ9oxRnWUauedkvH9FS2
         eM2rrXAOOMd8mp1WgYEfS3HDH64Y2lV1xTbBFXpJlLnqTOeYVM2v9cYmnXitQFTsB/R+
         EIJfy6chjvwciIrqVF61S5zOvfW0hkrtIm4kQjqrpisvRnULK+ULMZLDpuv0gcO0kWYA
         R3owx0M+OT9Ciuhyt41EnTPza27WG/7NuFzjgi+/WoyDRV8CubELkey0QmND1Rvx6+M4
         wSsw==
X-Forwarded-Encrypted: i=1; AJvYcCXO4P7hK9/AayCakzEpim+FP4pSj63cGE/+vNYP6QQsBIgWD+CcfLAnh31XDF7N82/Hb4tKGulRNpwv78s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAGQfRoYikcyZuQ93ICvd44qE2tMmgoV50Fk/YHAwtuuChAGqT
	fUQAhOtF1NLc3orp9/IngjU/ReQM8+Ec2QeWm/ACfvg5gWFvwUbe10FcPZ5y3ioB+g4=
X-Gm-Gg: ASbGncu/qWeurB/FbG/OdU2xToYOVqzXcFohHBfxy9NPnd4zmsSsTt069OQvhz6yDBg
	wNSUZun2B32l01ITJU9bxiIbLaGPvQtdvwttnAE0kdblUTUstAP5T6gQOsR8Rpaolat6Dg+0iSy
	5nvvbBREFkcP5tn0HSCbef8d4WyG4/BeSrhM9qezR60BFoelMXk2aW5qgK9unP/DEFbVaHM2L8N
	rkVX1iUuaHk4yVEDkPBAgcNQzM+9KcL8qRnwcoKaaid3al+E2o6E4xtq7cl32i6qXx0XYO9mWG1
	DzSjcd4ueVBSaFGpAgQuEDnP9wZvIN2qqLCIYVdOYB8XY+BNK3qCS2KpHI6icECwZ5Occbs9vVF
	nst5aQ8U1ZNxwfSmql52zTSAbX68Hd0QTFhQWh0GathNC+ZjNDKAB6KvvIyuQ/Wm9VRZ21MLlBV
	0=
X-Google-Smtp-Source: AGHT+IHNwvXqEF6vOTcSYqQI5K4auTTQ4rpyZ5n9iBhTRimnCw1sNSJGb5xwuJq4ksxZKKYMV+a4yA==
X-Received: by 2002:a05:622a:138a:b0:4b5:e2fe:31a0 with SMTP id d75a77b69052e-4d36e5ded26mr5451791cf.43.1758579012113;
        Mon, 22 Sep 2025 15:10:12 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4bda25aa5fesm76607461cf.18.2025.09.22.15.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 15:10:12 -0700 (PDT)
Date: Mon, 22 Sep 2025 15:10:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@gmail.com>, Marc
 Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp
 <socketcan@hartkopp.net>, linux-kernel@vger.kernel.org,
 linux-can@vger.kernel.org
Subject: Re: [PATCH iproute2-next 1/3] iplink_can: fix coding style for
 pointer format
Message-ID: <20250922151008.25c7a19b@hermes.local>
In-Reply-To: <20250921-iplink_can-checkpatch-fixes-v1-1-1ddab98560cd@kernel.org>
References: <20250921-iplink_can-checkpatch-fixes-v1-0-1ddab98560cd@kernel.org>
	<20250921-iplink_can-checkpatch-fixes-v1-1-1ddab98560cd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Sep 2025 16:32:30 +0900
Vincent Mailhol <mailhol@kernel.org> wrote:

> checkpatch.pl complains about the pointer symbol * being attached to the
> type instead of being attached to the variable:
> 
>   ERROR: "foo* bar" should be "foo *bar"
>   #85: FILE: ip/iplink_can.c:85:
>   +		       const char* name)
> 
>   ERROR: "foo* bar" should be "foo *bar"
>   #93: FILE: ip/iplink_can.c:93:
>   +static void print_ctrlmode(enum output_type t, __u32 flags, const char* key)
> 
> Fix those two warnings.
> 
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> ---

This is ok, to fix. 

