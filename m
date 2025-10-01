Return-Path: <linux-kernel+bounces-838473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93910BAF3E7
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 08:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F300175A04
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 06:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1951926F297;
	Wed,  1 Oct 2025 06:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G87NJZAY"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC66024167F
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 06:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759300553; cv=none; b=NVpqEZ4E/fHwduY1VIKwOhwqRUmR4v2QugE51wpfR3h5pcc7lymCm2QM51RyqfU8ssZ7XM/U0HeBtBFacJa6HZqB8tRuh5YOx6R0P4vXBmZhL34cuCEGBrS4SwX9Fm3uFGB5M3qUFRmuQRr67ULCAUG/SFKZMNSO3RmoY139tN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759300553; c=relaxed/simple;
	bh=8M+rC/tJvmhfbfPzx36kQC9pVw2SFMHjgSHET6OGNF8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=VewJUwSE1+FxVawxzqjNwxj2c/N78zI75UR1Zuh38YMAMiNiX1m+soYMqAmj1CNcvmXu6RN+UgbKL7/6ILnC9ArCao7lmX+edOpxdXiqvLIISZkj/HaYKhOhBLLU7CbwJijXDvPxs04FLrOtyKzxnpN4cyFny1deJv7CaJHUmdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G87NJZAY; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6349e3578adso12963318a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 23:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759300549; x=1759905349; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8M+rC/tJvmhfbfPzx36kQC9pVw2SFMHjgSHET6OGNF8=;
        b=G87NJZAYW9wnvpKWV+TPXsQLH9VLL8sQnB1i+RzjWkkaxkcxa2aZOPS5SEABD28JYW
         VqgpJKkl6oaZjc33vgsv5qReXc6vCCAvwN/KMrWv6qxuOD05TtyCVmMvxdOffMDtVE5q
         QID8RlEfwZPfPTSBobJdz24AjVxuz1YMaGzbUrhcWlURs03OXI3Qy1zIOoJOM9eh3AYZ
         t51urkgfwCVG41ZsMrTMmoRJL+IqJ74YVhYgGDfs6f+T3BJYzDc5suwy8rj4FJwEdvn1
         L74rc95DOx4FYoqUK0HB+MYo48A5LeLLpotAkuxR9h+X1Way5FqsDPT9frIATvZ7hbxZ
         767g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759300549; x=1759905349;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8M+rC/tJvmhfbfPzx36kQC9pVw2SFMHjgSHET6OGNF8=;
        b=ONdX70j7DjZ76KxxoWU87reQRV3bUCPWtVH+1Ma2JGdij7d8qL/Y97JPXyr91QKmWZ
         043toIdb5AAWtkC62xhwfBtgyjIIY2pHoOvszQX66+8y4CVb2RoKEpsd0L6q3ZZ+AOl3
         Zzw4e05Zf6A0N8dGjKRUYv6QzDAZeru+WVNjXNRi58OYxv2Jzg/ceFPk8mOtE+SHg37R
         g585IsD5jxrwxgI8LY2CnOrShOEAVjo18ROias2xSBk7M3UglyO1ne7N1V+15vreUlVE
         L03d3U4+1r2KIeHa38TZONq+6GJLSsa4nDay3znmlT2TH5c/fc6D7K1BP/Ud/tr6V8qy
         +0vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjZEqKTIEOgfmaHC8cQaRB0Vh0thJ4Pqkb7+ULz9Ia8k61008vpyRhXMgrfa35xDd++YCVz2QKkFpxO94=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXBRb6DhGFpYHk8bDRk8KixstP8/sX9PB4I/eMzJEN/v6eLdO0
	XK7OyqGYwYeZVfC4FJSOCJIiZyxFkrwsykywUuOEHb9VuXaVmluUUfYgZrR7Wx0QoMPAjFRCex3
	cazLU9NOHc7MnhgVGrdVlBJX4mwarJVM=
X-Gm-Gg: ASbGnctRIeD+bLutkKxmQNf7cFP9imKGIi9kRF8pJWYfbshKtnowXKWdf0usOoympBu
	R+mTA8oItPGc6cWXqy84AFak9ezDUQ6ORny3shG5pJa0QyT9Nbvk0GoBOKQrfZDD1BceM1luTSL
	kwr/pcZtVv2Hn4OZcUKN7iDT4KAz+2QkZ2LEL/c5p3zoRpP6V/asKhWLhP3UOQMHbVApzpkQoA0
	wMvcczgI+bwLsRnDyPtLtRHzYrwNDIW
X-Google-Smtp-Source: AGHT+IFhSXX+nUaYhO80kXEU0yzPB0CgeIXeTq5vOUpqxyC1AtlG+4GsR51QqMGGOM8phE9y25q6g3x8N6SySVVxVDs=
X-Received: by 2002:a05:6402:358d:b0:634:4e0a:9d32 with SMTP id
 4fb4d7f45d1cf-63678bce5ffmr2832698a12.7.1759300548968; Tue, 30 Sep 2025
 23:35:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Philippe Simons <simons.philippe@gmail.com>
Date: Wed, 1 Oct 2025 08:35:37 +0200
X-Gm-Features: AS18NWCYhciIG058jyCqKMC1WKNMOiPJ72urBhVvFFESB8Xm5N9YYcnUQcQrheg
Message-ID: <CADomA4-SQF3vyTNBK8gJsGRmC0DTr550S+RVoYiaKBRoW4TNBw@mail.gmail.com>
Subject: Re: [PATCH RFT] arm64: dts: qcom: sm8250: Add MDSS_CORE reset to mdss
To: luca.weiss@fairphone.com
Cc: andersson@kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, konradybcio@kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	open list <linux-kernel@vger.kernel.org>, phone-devel@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"

Fix panel not enabled on sm8250.

Tested-by: Philippe Simons <simons.philippe@gmail.com>

Thanks

