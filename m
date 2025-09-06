Return-Path: <linux-kernel+bounces-804173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC67B46B9E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 13:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 370F81B26D7B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 11:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BF328642A;
	Sat,  6 Sep 2025 11:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXG9t3jk"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F651A8F84;
	Sat,  6 Sep 2025 11:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757158704; cv=none; b=S5wHdCUhyE3rvvILva3QgJAxrkf1HKsR0IHBhZJvXJRBpzUtC1iFQgpmfbvUPOHR1jHPMz6LvbkFV09ynw1Pu3HzOh1Gk3oOOI+09KLLcbzQUxOmYj0aeq+7+3/Ns6gbPprpl+PkTXSA2VlEAtQlXWr1M431Q5c74l3jtA4HggM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757158704; c=relaxed/simple;
	bh=OYdBh8HqFVUTCDaCvvuGcXy1H5xtNbStwBTR5IHmnb8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=q7bsWSMQBESGaIMgViLNgtfJXoz7tGTAlSbIZMTZIdlF8QWzeFr3wuDQtbKLVMeDd022Jg5voDkCoMlvFmJwMKEuma6xcVzVZlKK5g15tReACUXXIL0+NmU8PDeWcesZyw0FcrPYkUuzeEBJg1fN2Ce2rU0nb9crVSsTx3VuGtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXG9t3jk; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b9814efbcso27582895e9.0;
        Sat, 06 Sep 2025 04:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757158701; x=1757763501; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYdBh8HqFVUTCDaCvvuGcXy1H5xtNbStwBTR5IHmnb8=;
        b=nXG9t3jki5Ta7swZrYCeja2nsTZ1X2Gm31JqFKRRc3NJCche23k4NxMqSwLVw6/R4a
         1CSGoXpCy9KTdnPf1Dv7aXjxaHe4zuvmuM3MOBjIeN6MBPqfWfYX27AoZi1s0s6naAnv
         k8YuSR5J6Lp6VDkXuJFxeU0AiAweoAjgSf0fx8JL0lCf+7rOyp/JzBtZiWcHHz5zBoI0
         oufE3xQRcGCZs5E6+cpC/sgS9jV8IQuOAIRfs4j35XhYsMLQz9qCT3YMoQ5nR3vHi5Tz
         CxFZrhHdCHZf8Wj+oe6aXBzQfDm5qiulVGh4whr8Ff2+QuTzK+5PSYKvFBGOVTpvP+Ie
         /1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757158701; x=1757763501;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OYdBh8HqFVUTCDaCvvuGcXy1H5xtNbStwBTR5IHmnb8=;
        b=YUu7A/2fBccQScleVTEh+ORHh5m0q1CSIaF1e8YDK6fL9fmFiyj1JDrpuwqJKhy1Ia
         1aTC4WXkPCVFMnmPZ51u5/DFHm+ZJvmu2ir0fzZInqYhdN75XbQddT4DCKJOvBfEATt3
         XPUspgJHlNM0Fe+1BVmswCyN8nmBFRVRzYD6Lr+u0AZbLFjgLvctVORMMkXqr5H9CfGg
         dK9IZb20twmuW43jnKEl9hVQYBMYpKn7g4qKsZ2qBDNXArgdQM27xxvn+1BCucpuva92
         naWgIyhF4C5jc1UqkFTJMHGeozesAGNAJQN/oZRH0xuX2Y4YalD3PDBiXHe70SGaDl3T
         IpIw==
X-Forwarded-Encrypted: i=1; AJvYcCWwgWyYkOm1mbmr5i5DlCNKfCYJ5witD5oohDE1doIhCWHjSuVdcIoTK1+qdDJualwuI50yHSDDjcCrrDQr@vger.kernel.org, AJvYcCXQmFynh6qX5VgkZFtkvatNota/vxxP40EiHnbKQruNFXWvYtE4EuFsBbIy0t1IX5v16NCfA8ZSekbK@vger.kernel.org
X-Gm-Message-State: AOJu0YwHXpl8GgJZoqBa7Fhbtkm0TK8w6sCAreqJvEXx8Dqr8doaYpMZ
	bAx31HEciwZDPzEc0/hTA/uGFSZy1Fov63MxIso7oHvUn6wMUkaL9NyE
X-Gm-Gg: ASbGncteJQlPjjHlRwU3HmyUwulnThkExSwMKQJoZ/ju+4E6RCT+cUgJOWGc1CzAcfn
	/RxIOCboLxVL7ye44HgiLTCPlFTbHzA1oUDEZ9tzz6HIn2nVBmP1PhAN5Z4mqMkAH7dQZ1MYIPL
	l0G0HvkYEeao4CYSlzsRmoOUDNGcYuvbbp9wzOIlYolBkMJhhPazwI3+g0HtKkzD3TF2ThllF4t
	UhwFVx1yXChUnsg08PbiYKNTIUDEI30ZPq+yvAIkQSfnMqI85qqC4sqRoy9vhh3+UgvbUmMTi0i
	6hjmB1tVjJFJfEbvqgWcIsurFiOWUZwqCqhc415v89pyono9VlQxOl2UMwk3v1hTg6J353GRWlr
	kRB7cOTHM2NQQI0NdN4ZyMqb8lKhLE6LTdNUowpw/VYWtRng=
X-Google-Smtp-Source: AGHT+IEpZhQKNYrVkTK3+mcth15u3ClT4pnjzS//5juTYMF8ueBViMJs+dSUMoUZqlbI5Gwl7TP02Q==
X-Received: by 2002:a05:600c:8b6f:b0:45b:86bb:af5f with SMTP id 5b1f17b1804b1-45dd5b32671mr56405465e9.6.1757158701184;
        Sat, 06 Sep 2025 04:38:21 -0700 (PDT)
Received: from smtpclient.apple ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d95df59e50sm19543645f8f.23.2025.09.06.04.38.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Sep 2025 04:38:20 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2 1/2] arm64: dts: rockchip: add GPU powerdomain, opps,
 and cooling to rk3328
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20250906112030.1829706-1-christianshewitt@gmail.com>
Date: Sat, 6 Sep 2025 15:38:06 +0400
Cc: Alex Bee <knaerzche@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3EC81CFB-7BA3-4AA5-8F1B-8E55C265338E@gmail.com>
References: <20250906112030.1829706-1-christianshewitt@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81)



> On 6 Sep 2025, at 3:20=E2=80=AFpm, Christian Hewitt =
<christianshewitt@gmail.com> wrote:
>=20
> From: Alex Bee <knaerzche@gmail.com>
>=20
> Add GPU powerdomain, opp-table, and cooling map nodes for the Mali
> GPU on the RK3328 SoC. Opp-table frequencies are sourced from the
> Rockchip Linux v4.4 vendor kernel while voltages have been derived
> from practical use and support work: keeping voltage above 1075mV
> and disabling the 500MHz opp-point avoids instability and crashes.
>=20
> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
> Changes since v1:
> - Use opp_table_gpu not gpu_opp_table to fix dtb schema warnings

Please ignore v2, I misunderstood the rename and should have left
gpu_opp_table and renamed only the second part to opp-table-gpu

I=E2=80=99ll fix that in a v3.

Christian=

