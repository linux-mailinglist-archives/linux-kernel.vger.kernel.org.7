Return-Path: <linux-kernel+bounces-782739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58738B3249F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 23:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE8E9623174
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87838258EF4;
	Fri, 22 Aug 2025 21:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6t/4cRi"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E287139D;
	Fri, 22 Aug 2025 21:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755898369; cv=none; b=SFdzRGroAi/gNcB+7kkgqzpcuoSfva0XBtgLpKpBOh4A40srCSbGm25FQr3IdNP6KwQRrbC0wdORVzL1kECb5jE5Gb51aaDdsYQfcihgrm4f+cvngJXAhRW1fvADek5CZlnsLOOiKchR6SNe2zgvfk9ZwsK+p+MVahLakxcFpsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755898369; c=relaxed/simple;
	bh=ixMKWo3lzm6zRpdkx+156QLT+Ke9uGNmMIv0XH8MyuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Um42FvQ5WCG9fibYKhqD8ogCSfZTB2Qv7vs2d5RK9TfzrGvq+v+JMhEFH1pEbBspc9Md/zmGGJUZlT9FPO9zsrc8xV3q9+51nPvRCLugi7osw6ArC6sCXEa9XuY8hFrRebaNg9PYuh3z1DpyZglhLYd1usrUc06YkbCmZmHeelk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6t/4cRi; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2463d76f04aso1677795ad.1;
        Fri, 22 Aug 2025 14:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755898367; x=1756503167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YP24RoThofEN7pELaiGsttmdvLW/LVrlSVSVwPZh4PI=;
        b=F6t/4cRiZqRN1mEny2rlScHI3qtLPmhUr+r6bOGmbR7u/w6KNjlLz3dqcelFBRUODD
         ovPvlV676APPLOpVEdDLjK5YG6+1f1LXY0wyjtB3xOIWI1WZ9TFRae2vB5Ppm0o+OCOt
         T4ifJ6+1Uji2TCyUNgpdKx642mjrVyTZwWHCUFttYkXHaoH5XKa368RugHqJ7/Ul84RC
         tQyOEJphYqZlBXeQGspkBVQ6PHqyILL51eo+Wtxiy1f2yupUlQwampK0OBkGGQdO+t4Z
         XxNBYJ+ovrmmhKX3n4a7BEtM/eDNJTXHVkTryOMzFSDeRZ4Mp2Bif4CTKDVg/+z8iqh0
         55Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755898367; x=1756503167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YP24RoThofEN7pELaiGsttmdvLW/LVrlSVSVwPZh4PI=;
        b=WFBMrQdeY+cXDyeilJysFAhrGlt1OZlvNPMgJp86OXA/yrSuD4HZGCc4tfCasq1bT4
         FMwSBMBr9JnV4UACPLsyhSjxe2JLv96Ma9Jg9RseK33Wrv4LJTwZlHeEYEFLKI+HCeOd
         03uvMRuB7OdPc72zOEfLM8h3U13oYp1Y083WFfZK/d3hibkCfoss2EZIyt6vuykPgDZi
         EnlDeKsYAzDCofmbtXZF/D7N9RvCtFcck7ra1C+A1aAWb7uKJyAuoQUVLcWwR9jrBJCu
         PBrzAaWmV31hrTaxr0O/Dqqs+wdgy9qVQ79QVmNPLyLKUobkygbN0/3tXOjElZ1oEDzi
         pD6A==
X-Forwarded-Encrypted: i=1; AJvYcCUnK0RoBfr+17j/QY7ECwbsUDzcVrj53JxqbRS9laf6L8UsXYW3pYXXtX4UNCj4D4+5JOTe+x2k0R5CvfpDEO0=@vger.kernel.org, AJvYcCX21Bpyfd6gq9LVhaXIuPN4P4WQ/1xZu+Br9jxK8Df2YIRVBDZ5G89NOzmVGG2iWb7IvAzG3Jnufp/3XbM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq9skeW0oz02yAh6hcrcMMbe1yu2HF2Pih1W1eOzpCkNwYloGE
	9jf0HlpZV6NHaZlelL9Gi14es7UJVcyTtyGYeZ1/J5EGhJhKCkzgArA19kCOP+9AuFV8MB5ySkl
	PAPkmqrCMfPqSqFmOMdmozXv+AWCLELInr8/E
X-Gm-Gg: ASbGncs6ijajRGZw9aJ1KezwJO8nZYN6oZNs6vjSnnwsWewnH4D+NEauU9SvRwqnBAk
	i7skrzXmOY2SfQNVTq626s82K+RLQwEtBzOx6zguUqqTTg+tZD2wAkdGY95gwHLUUSW7cMWWlD/
	EzKHa2bnu+/zxuSs42FrcjHE3v2vezaU8X89GW9jrDWIae1cpuZKTnvIdgjRUOw7IUuoC9n0Bby
	KuRPxAeu/g5XiprTaFiDNoEHci2e2s+0KKK2RVyfQ3V4dXW2PEiD5VS5ahKmwXiZCWSzskfG6qi
	V0xKq3ANNfmfU14uMNT3pRttrA==
X-Google-Smtp-Source: AGHT+IE4kUvBAJVFgKcoFTJJLNLnpJoaTYXAlZD75my0qFP0rgfpsBMQ5ve1h7Wk9ECkerDqbqBl9IpgmQmf1gTVcsw=
X-Received: by 2002:a17:902:d502:b0:234:df51:d190 with SMTP id
 d9443c01a7336-2462ee70d95mr34662295ad.4.1755898366867; Fri, 22 Aug 2025
 14:32:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822205715.83437-1-samidanielpersonal@gmail.com>
In-Reply-To: <20250822205715.83437-1-samidanielpersonal@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 22 Aug 2025 23:32:35 +0200
X-Gm-Features: Ac12FXyH0CBVss5b53NoC_5ufiDeKzO-85ih9qU1n9806J2QKcWBFe7TBOiX_cs
Message-ID: <CANiq72kFgbxvtGgWnwQ14vZ-8Yr4Oq2J_Tn1-jNsMiw_XXmYEA@mail.gmail.com>
Subject: Re: [PATCH] rust: Improve CStr UTF-8 conversion methods
To: samidanielpersonal@gmail.com
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 10:57=E2=80=AFPM Sami Daniel
<samidanielpersonal@gmail.com> wrote:
>
> +    pub fn as_str(&self) -> Result<&str, core::str::Utf8Error> {

Should we use the `as_` prefix?

The standard library calls this `to_str`, likely because it isn't free
and it doesn't decrease abstraction.

Cheers,
Miguel

