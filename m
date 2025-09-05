Return-Path: <linux-kernel+bounces-802245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 607F0B44F6C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F3451CC057D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7789C1DDC37;
	Fri,  5 Sep 2025 07:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T4y7Zqlp"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A512D9EC8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 07:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757057078; cv=none; b=WgzdB4sC2MKOaWM7npRSYeSiAN9fqsio0MaxkPiwJrxOGNSxq1Qp5ygnEvArxZvoU4Fa0MmhC/2cG16HdEneKcswtdVpJkxW4TKmpcFBUZJGlqAoX/MGTrYpaM1cRD9I0vaqyb4H18LaxVoAvkFyHQmY2vLD9UIWJpqcderuO2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757057078; c=relaxed/simple;
	bh=OyKNmBG7aY30CUsH6LThft0vL3sOjRv4PBRyIA8/9NY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HpRqMLP2AdWcvyJpwDH3kqxtb6L1hKz0KIdTakGkIABJmzm5XF5NHwnQwWaHgh4EM9BwBB9LAX9KX0y9x7W+e/z4WUTsnpNhYox21amfGJaWvSzoMxuEaDtyvJeA/IU7NZjzhm5i9BJU72+rtqHOtzdBPOFFKTlSyycSLbCGN7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T4y7Zqlp; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55f7ad815ceso2068529e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 00:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757057075; x=1757661875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OyKNmBG7aY30CUsH6LThft0vL3sOjRv4PBRyIA8/9NY=;
        b=T4y7Zqlp3JbqjDcSuyMxKuQ65s1HSZHa4rQU2jwHDrET83lNTxQ3J/WVUjIKQW+KAP
         Rn49e9We4gvWjVqxJMvRviVxPBwnm0FfrUPugQOOdQu5mcm0lglyMsAW+TLfqvAACVsN
         9jENFECC9J/nFhltr5eUV+hfKbngGFmNNkhSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757057075; x=1757661875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OyKNmBG7aY30CUsH6LThft0vL3sOjRv4PBRyIA8/9NY=;
        b=gUu+h0+l0lUD3l+ONanDU1iDrD4tWEOp92stnI+Q6ahoCozDW8P6Xx6yQX9PHezfSs
         2XA4YV32tbBGZiRSUJMc3x8AJveuMkaOktPzLQFh/ftpg1y1CfnVre/vC6CQDXqSEhqm
         5BPyKsGyUaaUZ7aQf1wZWYt2YU+00kqQ5GxOZkPIK+B1psISV8w5cSXsqmOREK/yeE++
         9tSl95eyURdJ3H3YoEzru8vnwgBWH3Ska6s126idkj5fFADsCbq0PaS3CekFxMR/yAjI
         s3D1l4Fm8HO55oLgr2VwP/rozZXrOI3LMJgFnHgtucsXELu+G9gn4WnBWcSw0Ubv3hF0
         VVdA==
X-Forwarded-Encrypted: i=1; AJvYcCW8lTWpaCOKcAd5oMrM8ldFGQTubWHpPglZ2rexl3ojj0UsauN4Rg9UkbxKuRYH1onu9+JtMMKUgqFP+wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YysRde3K8qMXlw9HGj95OlEwNmrTsRxAAKi1Y8DB/haCJh23ftS
	C2OyQJXDLEcuAOfJ26Zx+FgnJfH1jgDn/3cO5MNcpMb+csRPUhAXV4BiAXAtQ021W9fxJboTS0U
	/zawYWYyRo4ZfhNjQoFm7+vrVoLAHbriZGEtGSDTD
X-Gm-Gg: ASbGncuvh0+gIfzeKcwjGTMGEYfgDvoJu1h6bpwmlVg5vEkw3arVekWq3vHu1EW9fGE
	YNdWtakVZUCK/U3HAITe83DorfJrwi+VisW5p033EUVgsD4qKU2axYz2zQX01uaBNbOhH3IwV9X
	5+snzYWk76tyL7gdWp01Ic2q8X371zM8/C6zzFMIVCXslboOvkTz00X9/KfCFeF1T3fdQQmLO/0
	XLmKKlActUpkNqFefYChy71vHKZJqUQyUOJrPj0jivdTuzJ
X-Google-Smtp-Source: AGHT+IHsGV8p2LrSQ+5ebPuG3MwZsxnB0+XdK0d6HB4AboER/GhIXoUDzaGFZTbCNnePZ5YQiB7vHJZTSeMi3MgtzZg=
X-Received: by 2002:a05:6512:3d11:b0:55f:4e8a:199c with SMTP id
 2adb3069b0e04-55f708c2538mr6024739e87.20.1757057074896; Fri, 05 Sep 2025
 00:24:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829091913.131528-1-laura.nao@collabora.com> <20250829091913.131528-17-laura.nao@collabora.com>
In-Reply-To: <20250829091913.131528-17-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 5 Sep 2025 15:24:23 +0800
X-Gm-Features: Ac12FXxXPTzm9nG4j13NbvkvAJ8eK4LgCQVwRNdKf80aBqhtT_PDYtc5qR-IPds
Message-ID: <CAGXv+5HjrwPJBC-wina4ZrQe_3FBWcyZc3e+iaCCmNOKfMicsg@mail.gmail.com>
Subject: Re: [PATCH v5 16/27] clk: mediatek: Add MT8196 pextpsys clock support
To: Laura Nao <laura.nao@collabora.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, p.zabel@pengutronix.de, 
	richardcochran@gmail.com, guangjie.song@mediatek.com, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 5:21=E2=80=AFPM Laura Nao <laura.nao@collabora.com>=
 wrote:
>
> Add support for the MT8196 pextpsys clock controller, which provides
> clock gate control for PCIe.
>
> Co-developed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@co=
llabora.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org> # CLK_OPS_PARENT_ENABLE remo=
val

