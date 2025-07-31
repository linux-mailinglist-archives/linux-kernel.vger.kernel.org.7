Return-Path: <linux-kernel+bounces-751576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87798B16B0A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 06:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCC7F58133B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 04:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C39F1FAC48;
	Thu, 31 Jul 2025 04:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VA97okZa"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22A7A921
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 04:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753934833; cv=none; b=P9Ze2QSjb0zZX1Gy2jA4zmNJOcB9nV3NBVeoWedckieHuGTxM0Md+UC5/FqGYbvKvGR21tB1dH0wP6kDw0WAgtwCudJbp3Oa7/zEv+lv6olblBurUd6emruk7+hidvgGIzWx6tCvI/sQvmc7j4XEcYK05Wl/IQNx+B9dpuC3TTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753934833; c=relaxed/simple;
	bh=VYfZznB0Bwd01EwuH/VCVY8bkI+jlyZ0D2t//XUPrtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HwWSgknrl54OHillKaMj/qNyk0Z58Llhuwxl3nFmi1NJ/e5FDuR6l2kFSNsOPlmWCRSYlD8izvipUo88VTo+cX5AOCy7czq33DPp1taUF+qJhEjwOLmw/im1gGJWAuc3oj+CbgKkhpx/+Enwe0UIDLoU3WwYt2vu53+XsTuYhx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VA97okZa; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-88bab6d9216so127971241.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753934830; x=1754539630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYfZznB0Bwd01EwuH/VCVY8bkI+jlyZ0D2t//XUPrtU=;
        b=VA97okZaZ98iI0yIVrEhp+triqGzGNa3Ent74SChUsc4AhdFCQ7scInVPPP6+GqzIT
         gtecmip+IrH1cn/kF4wJLwkxp1CUwFufmka/TxiVcPrRPSNqBS/7m72mWtLqbM83ISyC
         WPMkr+KlUGh4UhbVfGED59rr2WYnCIFeNZSxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753934830; x=1754539630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYfZznB0Bwd01EwuH/VCVY8bkI+jlyZ0D2t//XUPrtU=;
        b=kJIGvoTHgokqV3+f6fbibTc9m5pnRXNZCey+RSdzDc5oUq43gLxXnn4hDh7eTmi7sK
         O6/OqruZJwiWq8VRwVdorDYnUkXmHPN3Wc2Kf6Q7bCE5EEt8oaQChOXeKhVUlaa9ZMZ6
         GuKihK/yq5XCeoema6pSk8jW1Q/V35o4qT2PkMV7xYMraFS6EG6q9OkX6kRwvA5gJzNh
         XzBWXwybqkQqtpKt9gtTwi0uA08OSZQpLfEtAeg9kZDxn2ejSRgrdThoEpGc9w74Wabj
         OQIIyElMsITXogDVOEYi3bDrkD1KUSUCGCKa3mvCDEQ3sC73eaBvEuPLghPym0Ht0I7h
         HU/A==
X-Forwarded-Encrypted: i=1; AJvYcCW/oLL2YwapXgQCnqwrzYlK7+sqyXWAaNKYbCphlwFatEcK/BOyUfLTfp76RCc34SDYnpfrH6CTKfLw3WU=@vger.kernel.org
X-Gm-Message-State: AOJu0YytgiRanrT1XwMEkjhjvvuQUO28fjszppC3c0ig06iCezuttuGv
	Z7VZN26Gh+EdppOkC2RPF8UWTQZnlPq75TLHH90tqJCMpTMw7aByZ9qXAFJLFH8ZL7XJnWC2efo
	MBTg=
X-Gm-Gg: ASbGncvrxb4BM7hew1A0dOBWo1biXaxPaE9GrI+PbdGMGrxoPfKmbH9q6zjRdsAhvvs
	ZmehM8J0WG0+TpmJk1Tw4tKAKcy3qZM/UZfVgI7a6B2gn/hb8BRXeYo9rlcbWsspm2ilGXsTCZ3
	QarQWDFRx+XrpV3jcxN5ioMAP0zg0HPM3Mwxe9xWqamAyCs1ni6NgNyeEGuJrxuUO8Y89xl9C3d
	SROQRqjpfzK7t2VNeMrS9OjhncpE2PUoFEoAuSabNqEpm7uUEaV7ZONlCXdPQfHS1g/K697MSEf
	WmbkbucTh3QIy3rKdQwP1vc744Aklds7El3bw1uNiTFcGNkr4z7GRE6/hFUPTpSReoFjz9Iv4WC
	XwiGv75Ui7vboS1KL20Vly22iYGTz+v+HHlFSH/Cjo3A1kXDGz+lC1sZdwg==
X-Google-Smtp-Source: AGHT+IHqlTV7AED23sCq2ergRi+0+KiY7zfsHFZIRQ8D8xdz5Qs4ndmtxBjSXjw04J0hMx0FdUed6A==
X-Received: by 2002:a05:6102:941:b0:4e6:a338:a421 with SMTP id ada2fe7eead31-4fbe7f1f33fmr3322200137.6.1753934830536;
        Wed, 30 Jul 2025 21:07:10 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88d8f44cda5sm203305241.27.2025.07.30.21.07.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 21:07:10 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4fbf83972d4so194726137.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:07:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV33jSwQeBjtwwtJ0gAHMkT7v/s400vMjyQZMirlOGrf/17X8P6gl7Ucfv3Hf+S6BCjxM0mMjuOD8kmWKE=@vger.kernel.org
X-Received: by 2002:a05:6102:fa0:b0:4e5:abd3:626e with SMTP id
 ada2fe7eead31-4fbe87eaa8cmr4099520137.24.1753934828784; Wed, 30 Jul 2025
 21:07:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730152128.311109-1-laura.nao@collabora.com> <20250730152128.311109-6-laura.nao@collabora.com>
In-Reply-To: <20250730152128.311109-6-laura.nao@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Thu, 31 Jul 2025 12:06:32 +0800
X-Gmail-Original-Message-ID: <CAC=S1nj0F-k37-v-gp5A4p3B_R9Q8exM+STb6vLhJ46=oQV6Eg@mail.gmail.com>
X-Gm-Features: Ac12FXzu20jT5Yk4GmMtSAZzZKsOMgulvP8pOesv2GOi_pI-RDe1qMoPgLQDq0Q
Message-ID: <CAC=S1nj0F-k37-v-gp5A4p3B_R9Q8exM+STb6vLhJ46=oQV6Eg@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] thermal/drivers/mediatek/lvts: Add
 lvts_temp_to_raw variant
To: Laura Nao <laura.nao@collabora.com>
Cc: srini@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, andrew-ct.chen@mediatek.com, 
	kernel@collabora.com, nfraprado@collabora.com, arnd@arndb.de, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, u.kleine-koenig@baylibre.com, 
	linux-arm-kernel@lists.infradead.org, wenst@chromium.org, 
	linux-mediatek@lists.infradead.org, bchihi@baylibre.com, 
	colin.i.king@gmail.com, lala.lin@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 11:37=E2=80=AFPM Laura Nao <laura.nao@collabora.com=
> wrote:
>
> MT8196/MT6991 require a different version of lvts_temp_to_raw(),
> specifically the multiplicative inverse of the existing implementation.
> Introduce a variant of the function with inverted calculation logic to
> match this requirement.
>
> This ensures accurate raw value generation for temperature
> thresholds, avoiding spurious thermal interrupts or unintended hardware
> resets on MT8196/MT6991.
>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: Fei Shao <fshao@chromium.org>

