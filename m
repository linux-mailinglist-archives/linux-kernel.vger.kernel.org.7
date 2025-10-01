Return-Path: <linux-kernel+bounces-838390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEA3BAF0FC
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 05:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1BAB1927641
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 03:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9AC1E766E;
	Wed,  1 Oct 2025 03:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kWI70OFa"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005591519AC
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 03:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759290524; cv=none; b=WxVgJCCqaTvYuQw96BA/0AEN8wY5eey2V2fjFCeRI3JKDbIsFNMAsw3vDMA0j//MLNy5iMjLIZga1jmci/L4Mooa7j/WKGPksQzEPMV09dNJifia9Fn4fQvkODuIRp6ddsPwQlS9YR+tVUnwgCYz6SHi1YkOS49HHM/vQL3yL6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759290524; c=relaxed/simple;
	bh=EdNmg14enyeeRuZIuVOC+Qcf5V1I3CceI2oqzht2f5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NO/er8IkFhHYUzthYqfgVP1hYxOomSNF312Z4nR7wviGFeogjm8m5VKm7dWS6JRaWUG03/Jrlc8GsFXKba/HFCA+qF2hH/cRRBnUv4OKkoc0pexZycp3U04slye5enFa0DlJaDuNoX5uH2zd/7NxpKQXNT5LUTiVKiaOnDRW96o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kWI70OFa; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-57b7c83cc78so569456e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 20:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759290521; x=1759895321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbDGpgTcV4nPy99Bde42+h9SYqbXF4/JT7azRtjchCw=;
        b=kWI70OFa11lNMwKHkKu1QNCj9EcNG4km6asrQIIQI7Bi0dMjrCVEHMhWHe1MeQv4Fi
         jiEOBcxXiRhqI66us7r6RwQOMgvZgePKYhA/yJGw/XoX1yh0sCfCcdWCCVyt6Mdz9IMt
         ieAj7Fyr127dLOQ2vVDeyJgw36axUIGVZ9B98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759290521; x=1759895321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bbDGpgTcV4nPy99Bde42+h9SYqbXF4/JT7azRtjchCw=;
        b=Zek4HkNSCkbMnmdJj3tGE+wm1J6BbiAbFt+EXF7X/8AF3+mVYaGtkjxXDDqqGdWGOH
         p1yRhrCMvAM/Bp3laj25c4v01OhwnUDZw5eToQSc3C6X9rZTIBLE0hJC7/tGWUpBY82a
         GbkDT6qcfjZpFt7Gg2ud+FOfR5haaHEuhD2MG06juzYp6HOvGNiK61CI/fUnW4G+l0M4
         +J9mc4Y9uWLe/szOiFI7jGDxcFAAmDA7HYkc54nQLgbvW4aM0hryMt62yDjOeOFcBrTc
         1UWQNCzuXcRREU1MDm+f98VEaTpENC0AqEu6DOhYzl8yhzkwBgDhZpYydVN4D6XjB8M0
         vZaA==
X-Forwarded-Encrypted: i=1; AJvYcCVwdjQEA1ImdU9eRbsVfFMDcMVwOBsadVpnduKM61y9++SAYAtZSmIPhI7WJTSV0UqaI1S7AJj6KnzayOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YycVg9onJs+yI25qWktJQgEI6PzYQYE8aHpLEyGtplKPwBZ9Sqn
	QGvV7zUs5wY6mR3PH+JOrBaM6XLKp0a29+rn1r9Iyjh6dZ5/ufpjFjsuv6T7u2VdwfQEYb/yl5C
	lHnXd/hGPRB8Nx5klElw/wjFbqMxQkYqSsqT6oVdd
X-Gm-Gg: ASbGnct7E12Hp4Nxk9FyfLbggXe8RwUIkp49jcSrobR7mtMNVyLESSe4vqEGzMp1rHs
	k7L2gd0nlzBEjgUVJeeG0a5b6oOZ5CQTaFv1k4Kcn9NTC3Qgn39zjAtawiucepaT4HWmBJ8Uecq
	1OXhjjvLREs3UABMZFzYR5zxVwnV62UUXJrt/ase44eUyjAoybjax9AEx/bOposUQKirhbFJET+
	Efb0ZLqmpbletvtypJT03Sp7Lq0Khu94VeonmnmxxWL4K3iEr8V/erJaN5vtw==
X-Google-Smtp-Source: AGHT+IEt27GdUNuEil1oCZ0SLhwUHChkXL8gmJhktqVVplGqcGKrSSp67qADibM4PY5Cnx6ufacc+rJwkmcCX3eGhbM=
X-Received: by 2002:a05:6512:6181:b0:577:a108:93ca with SMTP id
 2adb3069b0e04-58984e225bbmr1821361e87.28.1759290520880; Tue, 30 Sep 2025
 20:48:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1710418312-6559-1-git-send-email-quic_amrianan@quicinc.com>
In-Reply-To: <1710418312-6559-1-git-send-email-quic_amrianan@quicinc.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 1 Oct 2025 11:48:30 +0800
X-Gm-Features: AS18NWDDl3OS7A4mcJKeQv_2tDSls1y22vmY0gN81pxraCtuEd9IP-mkQAX3bNg
Message-ID: <CAGXv+5FQSETv62FS32=eadBWwZPB_ShaJ3_P0cksnL=sdBwkFQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add board-id support for multiple DT selection
To: Amrit Anand <quic_amrianan@quicinc.com>
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, kernel@quicinc.com, peter.griffin@linaro.org, 
	caleb.connolly@linaro.org, linux-riscv@lists.infradead.org, 
	chrome-platform@lists.linux.dev, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Amrit,

On Thu, Mar 14, 2024 at 8:13=E2=80=AFPM Amrit Anand <quic_amrianan@quicinc.=
com> wrote:
>
> The software packages are shipped with multiple device tree blobs support=
ing
> multiple boards. For instance, suppose we have 3 SoC, each with 4 boards =
supported,
> along with 2 PMIC support for each case which would lead to total of 24 D=
TB files.
> Along with these configurations, OEMs may also add certain additional boa=
rd variants.
> Hence, a mechanism is required to pick the correct DTB for the board on w=
hich the
> software package is deployed. Introduce a unique property for adding boar=
d identifiers
> to device trees. Here, board-id property provides a mechanism for Qualcom=
m based
> bootloaders to select the appropriate DTB.
>
> Isn't that what the compatible property is for?
> -----------------------------------------------
> The compatible property can be used for board matching, but requires
> bootloaders and/or firmware to maintain a database of possible strings
> to match against or have complex compatible string parsing and matching.
> Compatible string matching becomes complicated when there are multiple
> versions of the same board. It becomes difficult for the device tree
> selection mechanism to recognize the right DTB to pick, with minor
> differences in compatible strings.

I plan to revisit this topic, and also include device tree overlay selectio=
n,
at Plumbers this year. I was wondering if there was any progress or changes
on your end?

Thanks
ChenYu

> The solution proposed here is simpler to implement and doesn't require th=
e need
> to update bootloader for every new board.
>
> How is this better than Qualcomm's qcom,msm-id/qcom,board-id?
> -------------------------------------------------------------
> Qualcomm's qcom,msm-id/qcom,board-id are not scalable for other distingui=
shing
> features as we need to add a new property every time. Board-id property p=
rovide
> a solution that the bootloader can use to select appropriate device tree.=
 Board-id
> encapsulates soc, board, pmic and oem identifiers. Qualcomm based bootloa=
der can use
> these key-value pairs to uniquely identify the device tree. This solution=
 scales well
> for cases where additional identifiers would be needed for device tree se=
lection
> criteria. Adding a new tuple in "board-id" along with "board-id-type" wil=
l help support it.
>
> Changes in V2:
>  - Based on comment on V1 related to challenges on designing common bootl=
oader for all
>    the vendors, where different vendors can have different representation=
 of board-id
>    and the best and exact match logic can also be different for different=
 vendors, moving
>    the board-id definition in qcom specific binding.
>  - Adding support for board IDs for all the boards that are in kernel.org=
.
>  - Adding Qualcomm bootloader best/exact match logic for multi DT selecti=
on.
>  - Keeping list of other vendors in CC for comment/awareness related to t=
his requirement
>  - Link to V1: https://lore.kernel.org/all/1705749649-4708-1-git-send-ema=
il-quic_amrianan@quicinc.com/
>
> Amrit Anand (2):
>   dt-bindings: arm: qcom: Update Devicetree identifiers
>   dt-bindings: qcom: Update DT bindings for multiple DT
>
>  Documentation/devicetree/bindings/arm/qcom.yaml | 90 +++++++++++++++++++=
++++++
>  include/dt-bindings/arm/qcom,ids.h              | 86 +++++++++++++++++++=
+---
>  2 files changed, 167 insertions(+), 9 deletions(-)
>
> --
> 2.7.4
>
>

