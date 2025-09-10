Return-Path: <linux-kernel+bounces-809849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A47B512D2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3AEA7B9284
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C5D306492;
	Wed, 10 Sep 2025 09:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eBS0yNdg"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158F3313E06
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497185; cv=none; b=B6cTT0K1ABNeC+lGZJGAHwK7QvnnlkKJYlk0Bl2fGcBUeMiUDGwUENhEzftAjfk+3/xt7XFzjO9FE4tLRsOUk5dK+Chiqn3en/EyZS+UFyR5xXSJnD1Cyyf0+Mmp1PEqCsmz4A2+/srvWeU+5pvFv/f8niapwnoGB+OwUN5843s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497185; c=relaxed/simple;
	bh=m3w9198KPcW52Kq5czGxwlCuVIFnmkUpH3jecGwOHRI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S0MuDg7RlpalcMydEqPMJLFtpNTp2eqVLjt7xkamEy0mZjE3lMaG6AecKA0w3/jsnmMDRKCM7tB+bHKgfpFpVs/++vfkqBxekxeLIub6gj7I7FMsDWb0v94CtmhYWwQjfHf4ZMujcxci+z9+nC3mvGzJvB7v9A9AQJ9mj561sug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eBS0yNdg; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b03fa5c5a89so943047466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757497180; x=1758101980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3w9198KPcW52Kq5czGxwlCuVIFnmkUpH3jecGwOHRI=;
        b=eBS0yNdg85VxplV5PCne2faobtNgQxz+twlD68Pv/00siAxIwglmWONslGqd4gBAU/
         4niFf9F3VP+vKf0OC89wthO4adjThbN5N+9cMOqLxFIG6/sSJmmczZ4NUy98aYsb3204
         5e331kyX08f3b+L/zRJD5C7pSjb3GCf7dGtwHY0bcqbp0hAQzaNwMm5XOLJyayOR/w4t
         BbG9PjOUS9i1+lRR1kDrqA7c5NZiPMjoDQp+kpFJr0d5HdJLLCzDobM8BuFmnreKsEI2
         ErkE7l1WOH0L0j76gj4tPssOd1C2+ZtMphaqF8v0Viwx7WayCZsr6SqJkkDC3a8KrJ5u
         eCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757497180; x=1758101980;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m3w9198KPcW52Kq5czGxwlCuVIFnmkUpH3jecGwOHRI=;
        b=uvjxYLVYtvS9VPkQhuDUvIKb+Ou6y1UptLGM8ku40DVS4W28ahljb6oTsFB2NlgpGt
         C4BLcDu2ftxmZO+QiPuy45WvwGrF3Y0s2Q9lVVLTDBui00p06TM/ElCr8xhfba1n6gIA
         bBXTjP+5uHDP03+dzBc+3pPgDZ5HbfXOkZEOXGLEsyAHWHzS3OlewrGVR/g19vvARpIb
         9oWIPiwQvrxv/7MCDNjbko923NapY5xvi4MlETcHPEk3lZbAyaz8r/jd94XMNdX5xj46
         hO+hrvlLbQjqf33jE03OKmYP70ZG/369VHvkIr3zETUCEimkkARM1QVetBGUT7CI8tcD
         8lgA==
X-Forwarded-Encrypted: i=1; AJvYcCWXhSfQuej8zVEXnaNKasfKjgF7u0boalNoBUIhfu6lAytJxvgdUgGDF7tzEgO7WYnpfgnEkMMh0t7Gx84=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAWQVtkiioZKniFHuAmCObQ8gww78tmYf0GJX3Z77mmfESwIRx
	3vm/PFenASRURBZNEnEQeeBxsU9RFiH2OuaxsJNwnfrN/HEoPIjFrxy1oqPbDheDyXXKlqUNDlP
	sHm0v1P0=
X-Gm-Gg: ASbGncu7IX8PYXrDZ9GTbrncSqN9maOVfoxX0VgygoDAYZJChSaaNHUN9VbB0poTCp3
	l8V2pakSX45mUGtlnMPO5gs1LueZIdxPhnaWZ+IrQAcrRS+SaKDnFLN/Tb/lwSAW17ToVWlT9HU
	fQlvXt3u5UqiV8/UfVG4vO2a247RX9eYZz9NoF8uVTPnh9ND3pG0rg5Wv1ZgPefKRF47z+JCQ4n
	w2z4YQ6bt2BGmZrfCTlt0mKDg6lP8oMgX/aASaVkAXOTsXhCsCJqQ8ZSRl3BT5yJJ1Q9hd20fBr
	nEtiRJSyQyvISupM5by5wXjzzfUffVjfhOr6SLRnau9tzQ2iQpXXbpY9pHpRlhSt1kGjCk7vJE4
	E3D04tkV0VLNXGrxI1/mE9I6/lN/1ObTLtw==
X-Google-Smtp-Source: AGHT+IEgLz62atvGYTtgWhK0IqE5DaeMbopSvx9UyamfacYq3cpWns33qwgJoigjRNFokWLtUFrPnA==
X-Received: by 2002:a17:907:97c9:b0:b04:1a1c:cb5b with SMTP id a640c23a62f3a-b04b13fd491mr1455086066b.7.1757497180392;
        Wed, 10 Sep 2025 02:39:40 -0700 (PDT)
Received: from draig.lan ([185.126.160.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07833ac0c1sm138008066b.84.2025.09.10.02.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 02:39:39 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id BCED35F82D;
	Wed, 10 Sep 2025 10:39:38 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: <andriy.shevchenko@intel.com>,  <harald.mommer@oss.qualcomm.com>,
  <quic_msavaliy@quicinc.com>,  <broonie@kernel.org>,
  <virtio-dev@lists.linux.dev>,  <viresh.kumar@linaro.org>,
  <linux-spi@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <hdanton@sina.com>,  <qiang4.zhang@linux.intel.com>,
  <quic_ztu@quicinc.com>,  <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v9 1/3] virtio: Add ID for virtio SPI
In-Reply-To: <20250828093451.2401448-2-quic_haixcui@quicinc.com> (Haixu Cui's
	message of "Thu, 28 Aug 2025 17:34:49 +0800")
References: <20250828093451.2401448-1-quic_haixcui@quicinc.com>
	<20250828093451.2401448-2-quic_haixcui@quicinc.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Wed, 10 Sep 2025 10:39:38 +0100
Message-ID: <87wm6663z9.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Haixu Cui <quic_haixcui@quicinc.com> writes:

> Add VIRTIO_ID_SPI definition for virtio SPI.
>
> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

