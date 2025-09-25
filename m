Return-Path: <linux-kernel+bounces-831956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33390B9E005
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB2D64A0398
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD072E54A0;
	Thu, 25 Sep 2025 08:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cp2oTldF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2075224A066
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758788027; cv=none; b=e9RKEiyc7ir3aukErp4yrExbFAqcJrQ/12BAaH0+kfKuYwmgZjoMVbzwVVK9DJsEDztXC2a1weaUkbpo5l2Jv/XuqCB8J+bu1Wxa5NqyWvVdUhjXRm8qrUjDuWzchQPrCdOg8DxoEXGhwHPff2dyGMkXgS4GurJnx6DomN601WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758788027; c=relaxed/simple;
	bh=6xgy1DV8hqDQp2+4paukanNMqpv3nebP7gwfsphXnFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NsmZAZPVrSuu/6lGxBwal261RObLqRrjrmKjk8Cwz0tWZz3rxHmdPmcnImWcMjZvv+DKfcDzClUlbsyxNTq8iBqLoqeIQwi61EkYAYcmHSKKO9BLYxwtuyiAqtkQ7QArWge085uJ+ntnhq9kmbCbMf2s/hYmh125HN8X7KcnaoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cp2oTldF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011FEC4CEF0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758788027;
	bh=6xgy1DV8hqDQp2+4paukanNMqpv3nebP7gwfsphXnFU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Cp2oTldFqmMioL66dq+cIdA2fwv+76nFe+nvnhvtMx4bhLYvE/pRgBshuVIQIk0y+
	 c7vUoT03pKhyHb+h5VbpXDht3Us/TTAMJEwmihhFQVc51ZVWBRtn00dX/awbOCiLJg
	 ZKRUsdEFy1d7seyI5aMnZSxIspkZir2z2ugHzAK0ObYO+w1EZoYScOQJb0dFPdpjVn
	 a81ejpR2oX2b4wbAFVsDb4Jh2aV+tWrERgKoUtWmnHtvGoN0sAa/NJXz+6Ih4dptLO
	 gsWq0yE0J+RUDirqvySmWz+g19i5K2//Nf5NcKZ3s5rNp6vfKqte7Aq5+qT9WNjli+
	 QA3VG6C9eno6w==
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-279e2554b5fso5961015ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:13:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV3WnCq0ynRoEGsMJd5H7YugTI3aSRxzkOwjj5EL+K1e5GzudZNSrgSQjSIvKB8/Guwt0Jjv3Lxh5YMgNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2TZi/NwpxUd5NYWtGm/fUr6qXpEmFCgzhh79C0X0iRnqjhHbb
	YeXmOG6UBcec1CQaWIbWuhx759hcjOzz+mv8mrt/rKZ+xGVvLDrmxcG6lWQRg3bRiMdSw6O8UkQ
	wMy5ZQXL03Vdron7ynZQcChUqnOLiVCY=
X-Google-Smtp-Source: AGHT+IF236jaAp4/rzwPts8ocm70Wj0QKGsGeIC5djJA3YS+DawATMEDddVRK+GjCtafW4q45y03wn5Swx20u9oEeyI=
X-Received: by 2002:a17:903:1205:b0:269:95a1:94c2 with SMTP id
 d9443c01a7336-27ed6ad069cmr22371485ad.3.1758788026613; Thu, 25 Sep 2025
 01:13:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-18-24b601bbecc0@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v1-18-24b601bbecc0@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 25 Sep 2025 17:13:34 +0900
X-Gmail-Original-Message-ID: <CAJKOXPd_TgLBy50evLVO2LXS7N2S=yHKO+=AwpQv1On==nDWTQ@mail.gmail.com>
X-Gm-Features: AS18NWCkq1NL0OZpoilVWTB3c_ZC8sqWHMtnKD12Y3W3MiBMvTJMZuW_VvZuNTg
Message-ID: <CAJKOXPd_TgLBy50evLVO2LXS7N2S=yHKO+=AwpQv1On==nDWTQ@mail.gmail.com>
Subject: Re: [PATCH 18/24] arm64: dts: qcom: glymur: Add PMIC glink node
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Sept 2025 at 15:34, Pankaj Patil
<pankaj.patil@oss.qualcomm.com> wrote:
>
> From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
>
> Add the pmic glink node with connectors.


Please stop this. This is not a separate commit!

Same review as year ago, two years ago and three (probably) years ago.

