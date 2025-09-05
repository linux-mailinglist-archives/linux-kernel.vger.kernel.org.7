Return-Path: <linux-kernel+bounces-801996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6466B44C9B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 955173AC075
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9BA25A334;
	Fri,  5 Sep 2025 04:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AJmhAq/I"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B43233155
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 04:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757045408; cv=none; b=bnQuzb8PI9PbGbmfRVXc7ZWWOmok59wm+gFSLizFuNDzkcdPv7RgX7P+aUMuy8RCX212J1sqEWZmQeAiPiK/DEJgqIF2lKK05nw8Dl6T7byA8gR4rIiDxpTk+7SUuNgVLnFmw8nPdc4CTcv4GsLDZCKVv42jmtchqllKimCoP/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757045408; c=relaxed/simple;
	bh=KLKUHPIcRB0O4muuVCBP8C+yFYqPCsP1VfYmF9nYOvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fHzEU5/LHWWZhVg2yYT1HMUFZDpnxdebFW2GU24J721Hyd5n0sQksjOnemkvhMvwF96q4bHysU7VaAW7ziw9FjUhtwj6wVctkLisZCfab99VWTcM2kWdzl8CHft0PNPS+Cztwx2JfBFqtUYVu0PgBsb62swP//HnnpDRp4ZmVlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AJmhAq/I; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55f7039a9fdso1884140e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 21:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757045405; x=1757650205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLKUHPIcRB0O4muuVCBP8C+yFYqPCsP1VfYmF9nYOvI=;
        b=AJmhAq/IP/BSeLkYccBXDi13Lp40Tvzens1nJ4WoC96MTkj51upPoaMdlbP2lw+rek
         HmuWGup7FR1jfacuCYzjWNmncw6qQwsRlHjJUpn0vB55FPRTxJZdnhEB+CjTekrH6Lht
         IhNDMHwmyGKR9OQW7QmfLz4Z7E3axvGkJpoXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757045405; x=1757650205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KLKUHPIcRB0O4muuVCBP8C+yFYqPCsP1VfYmF9nYOvI=;
        b=XaQNWqCRUzr9nC9MA9lAVQYd15x24+UxYNLPK9dL7pRSt5+IOvjh9DRzHALUuGvKg8
         nFQv48LPtdypvqADC23PVtn2JLd0RwTyBZS8ICDGaqOc0kcvwjJ8TOsBJ4gBkfJiqhZv
         vstkYDRUJ6w7egl6k8xr1Yyz6bTjaSSAcWyPK7fgjNbxOQdJTaLuAwMXokm0IkQl7Ok5
         fJQh+c5jbXxYA3rHDT4pc39xLspAfNtNOf6NJr2erqbv562UxdOs1bohpJpZaqyN6c9S
         P08BVHj3c65lWkf0oUSRZ42PELwMvXeVTuf4zAverFsvaqksiKWk7LHG21rOe3sGjWlt
         ohyw==
X-Forwarded-Encrypted: i=1; AJvYcCXnKIOCVcO3cOu/lzBN9Iu/hrfMUU6T76Vj4wDgx/DczR2YxkOYYebTDuS/UDxPFFyK6oBytIgigQqb6yY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEaZ6B3Rh2wKOajLaj47PuOiyfnBHdAzn9fOHPCbdrvfxQlUlx
	8tS0t4DSCVtRBNEhHQW8cFdWdDxcA8GpiKU0+kJ3cZiEFhPKmVKNyTyhSCzqNasa5t4j4HbSQkN
	AllfW0h+ZhVqYHXiTCROMixXExeJIWkqgW46/SHDX
X-Gm-Gg: ASbGncuOko6bJ1vvQ//THt7FA293aO5ZHvoj2+/3uQP3zy13g2z9sRutvKZiPlMVzYq
	iAt4u1FdGWbDXMR42XUtavxt2U7DuvMtvoQT7PGNlo7HsZGygbqCoP6yWaC91qBSKOU5PoY9dS2
	NDpH668QpUT2ru8MMDS3Jp1RbekzjcYNvnHHL1od/3kyos5UeoNiSqtUSRTlkir63gWqBbVV6G7
	YZJDGPe4tPyoUwr66YJZ/qxDTfvmk4xoOvlWg==
X-Google-Smtp-Source: AGHT+IH7HKhnxC6o9ewQ28R2ZzX9RmDQokY2C+2i+wMjE8WlWqsz+BTU++rL/6Yzgiv59B7OTvBGnUhQzmndeoe72TQ=
X-Received: by 2002:a05:6512:650f:b0:55f:65f9:512e with SMTP id
 2adb3069b0e04-55f708a2a7fmr4251279e87.6.1757045405415; Thu, 04 Sep 2025
 21:10:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829091913.131528-1-laura.nao@collabora.com> <20250829091913.131528-4-laura.nao@collabora.com>
In-Reply-To: <20250829091913.131528-4-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 5 Sep 2025 12:09:54 +0800
X-Gm-Features: Ac12FXx6pAx7CiAA-H5MAQbshXKRXROm_6MtHlpf5-g4LpJf9Fu8XFakXK69rOQ
Message-ID: <CAGXv+5ELv9vR7i_Xd7XCC7gBciMXPfQfDAD1WyNy89=pJaLC_w@mail.gmail.com>
Subject: Re: [PATCH v5 03/27] clk: mediatek: clk-mux: Add ops for mux gates
 with set/clr/upd and FENC
To: Laura Nao <laura.nao@collabora.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, p.zabel@pengutronix.de, 
	richardcochran@gmail.com, guangjie.song@mediatek.com, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
	kernel@collabora.com, =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 5:20=E2=80=AFPM Laura Nao <laura.nao@collabora.com>=
 wrote:
>
> MT8196 uses set/clr/upd registers for mux gate enable/disable control,
> along with a FENC bit to check the status. Add new set of mux gate
> clock operations with support for set/clr/upd and FENC status logic.
>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

