Return-Path: <linux-kernel+bounces-723515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B74D7AFE7DB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7036188700F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FC82D662D;
	Wed,  9 Jul 2025 11:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="U/O3yJ0D"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7232882CA
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 11:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752060785; cv=none; b=jiRWm8q72Hk/NGULKpL49MIRyZskCooGopnQqXk9w3ttcWbzwX+2XAK2Q9Aobd5jxjvJDd3vePH823qI5SEBNWAaQIxU+XRM8nsO9xyasKtHPAq1oWrnNmKHtt16pKnnYctTJShzJiEXp0n+y5Mp52DW0rjXKTHBnAKZve5ipmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752060785; c=relaxed/simple;
	bh=DnetqG4IpAFzDIBOiu8occs+wrG3pJXMqq/lD/+CZz4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=iRt17myZSJ8JQB9bkxBGDhPO+wYm4EyTtF7P+J4UJLjKIJKqe280IX4oLJtR1gDWBUC+yeFtepT7lZuiIy8vXB7dqwfYWalA5tqrbvPUtGHLdT1gvJ8ig2kiuQVlq7gFstkI5orc+v2JOpfF7x+47OI4benS/dKYcytW3W1ghW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=U/O3yJ0D; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae3b336e936so1002979966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 04:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752060782; x=1752665582; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxzY42f4mxHddEBUOVLLBJrN9aKCSop49so8dLkLQco=;
        b=U/O3yJ0DN6baKxv96FqzOocjvo45nVp8hpkpdara9EBtCODvwbHYkh85hmgXQuepCQ
         6r+M7hwY/lWt7+6gGFPu/PgBusr4yBAW0SBJPSOjroaY3T/b2oY/IhMWRD0DHIc5FECB
         KEJkW4b2jbJlXiQjYZoNJqO4C5Dw9R5Cm5dnlNSxoT3SVMPLsiBWsApd3ArSED2iJRF7
         kNPCzd9j3+jTSuCY0CCcEdqhf5laX7gIPG24ABli63mSv+h+tw6Dl+HgQ2x5angC6rX0
         1h6oYofb4mNsVNb3jbyVYROXUtfcyHKdIi5b4dPflY+h7ge6u6z3C/7Y2+Qt9V+jLQW7
         awuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752060782; x=1752665582;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KxzY42f4mxHddEBUOVLLBJrN9aKCSop49so8dLkLQco=;
        b=gJFwrqpDviifE77l9MV6pJbbg5G6cATLy+ZIIddvWmZ6orJMMF59b7tsd7cp+yZ/Gm
         1rIUQftFn1DOvmaNmrtPE0t6DArJs0VHXBBF4rc0F1uhhsuIOWLY1E7aSuNakX5A2gbf
         KyYcOb5F3NWAK9z3ZtUctPoDPJjvZs9TwzWKyi3L2axr9ra4Js81GIrx7Pj5mXMPfJId
         W956k142GUjuI5e02OIp/lptSQ/9toYzh+E0Sh+vFNY+Ra+tEaebT13UDfagGIsQmP1b
         PtoSk7EudEVAZye+S6ivjbwc0Z4JQNrV1OafoB0J7Eiq49NN3dYDJWk5zGPJ0Qggc8oz
         LNxg==
X-Forwarded-Encrypted: i=1; AJvYcCVOIINIYBp9bwuvpokdBkf3HbuDc19vmnLl5aXYRrGkMBpsGItYp5zNEHahwoBtX0qgaRRVUG6rFeqtjEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt/+ffVuE7XOsNov0Kmr+OT+gYMjz71tJifVjgJSiJjRzlz01v
	RP1fPg2iVhIyPo72pFO4n91jtvyDZDgV9p3XTsX16j+jXEVLPp4GXrPNU/ftkGpxx28=
X-Gm-Gg: ASbGncvTYCP1adc96c+946OuNF4WR/VSyYGLEDekiKr4Mu5EwjhTCz8YyAjDgWwtz6n
	fIWguhwZKF+ovQ4yKINmsNdSnKyDVEOIaYMm1O8XRuZl6wpWYVQ4BYjncmFxkiPrG7Q+wboLQuD
	nkZIqfqtFNaSr8rNRomepMtq9xEKUA52ugcGAlh3Bks0ilnftX38Qy1S1eOCGthsCdwZfeFKEr7
	NzUmCH3J71MIaz47YBz8rlV4nBG4isxDHxh6m2poO0Wnf1Yq5vS42OA/7Few0huL4mxfAjKThYO
	5AvcAOSWiTgCAoCbe2OIq7yT8y75f+GVMDyC+gOs6OiT3TMi0ssHYwdkYYl9aWAINTm9HFqn3zq
	VPfENoH1HEk7SgwykyTprkHfg+YZQqiEudCwruzWdug==
X-Google-Smtp-Source: AGHT+IGHM8DEDRJmkix2Dsy2SirVJ7BbYv4bV5HgWFOqwJ5zCocvDi8X0Hn8U2z4qSsef7dQPV0KjQ==
X-Received: by 2002:a17:907:6ea3:b0:ad8:a41a:3cba with SMTP id a640c23a62f3a-ae6cfc3c275mr235877666b.43.1752060781983;
        Wed, 09 Jul 2025 04:33:01 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6bb1edfsm1080433666b.180.2025.07.09.04.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 04:33:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Jul 2025 13:33:01 +0200
Message-Id: <DB7HPNBDW93U.2RC0AF8T8RG5Y@fairphone.com>
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Bjorn
 Andersson" <andersson@kernel.org>, <~postmarketos/upstreaming@lists.sr.ht>,
 <phone-devel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Add Milos RPMHPD power domains
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Ulf Hansson" <ulf.hansson@linaro.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250707-sm7635-rpmhpd-v2-0-b4aa37acb065@fairphone.com>
 <CAPDyKFonLENQbafjo621hHPkoWjMNoQ5GRNeNndpezMNnM1=sA@mail.gmail.com>
In-Reply-To: <CAPDyKFonLENQbafjo621hHPkoWjMNoQ5GRNeNndpezMNnM1=sA@mail.gmail.com>

On Wed Jul 9, 2025 at 1:30 PM CEST, Ulf Hansson wrote:
> On Mon, 7 Jul 2025 at 12:18, Luca Weiss <luca.weiss@fairphone.com> wrote:
>>
>> Add support for the rpmhpd power domains in the Milos SoC.
>>
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>
> The series applied for next (with a minor update to the commit message
> for patch1, according to suggestions from Krzysztof), thanks!

Thank you!

>
> Kind regards
> Uffe
>
>
>
>> ---
>> Changes in v2:
>> - Rebrand SM7635 to Milos as requested: https://lore.kernel.org/linux-ar=
m-msm/aGMI1Zv6D+K+vWZL@hu-bjorande-lv.qualcomm.com/
>> - Link to v1: https://lore.kernel.org/r/20250625-sm7635-rpmhpd-v1-0-92d3=
cb32dd7e@fairphone.com
>>
>> ---
>> Luca Weiss (2):
>>       dt-bindings: power: qcom,rpmpd: document the Milos RPMh Power Doma=
ins
>>       pmdomain: qcom: rpmhpd: Add Milos power domains
>>
>>  .../devicetree/bindings/power/qcom,rpmpd.yaml         |  1 +
>>  drivers/pmdomain/qcom/rpmhpd.c                        | 19 ++++++++++++=
+++++++
>>  2 files changed, 20 insertions(+)
>> ---
>> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
>> change-id: 20250620-sm7635-rpmhpd-dcb5dc066ce2
>>
>> Best regards,
>> --
>> Luca Weiss <luca.weiss@fairphone.com>
>>


