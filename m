Return-Path: <linux-kernel+bounces-740177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D823B0D10A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 06:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 666486C3981
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 04:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD8328C5AF;
	Tue, 22 Jul 2025 04:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LATWByUv"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1132428C2BD
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 04:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753160318; cv=none; b=UGdvjKSve7R6ZJcZ76nLl0jJMtRjMIQ2dKfrikLTaZB1Zu2qYOZPfsAIsXL391itbjJh6gjwUDjeVECclUkIvStYEFmx2IV6ZnqtECqZQkw1juJU1H7ODeFcCLRj3L3d+lCf8nbDsg8U8yIDDyXaKBCznKxCIEeCvrK+iPgMI1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753160318; c=relaxed/simple;
	bh=zUf4AlEkQu4akq53baJqj49MOp0hPw1pbtMFQqaD0kY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yo+54BfmZSzi/Qyq58G48xkD17RAKj/Lq33dcTLFu2SObGyOOii6OOZZL+dSgMCex/2yFTPx4p2hw0FDMTn0Us6DFvNGA7s1YTZyIaZRm7vnMTnf8lhEF+eJSyU4KFBeFhui3ZrWJ8eLrkq+PvK6MXkxxMyNAGuhxYo4SpDGHhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LATWByUv; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-32b4876dfecso53796981fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 21:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753160314; x=1753765114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUf4AlEkQu4akq53baJqj49MOp0hPw1pbtMFQqaD0kY=;
        b=LATWByUv+olVJQNT+w8RvwbcWmVtfd0mY+op9jUDOoD+KPeFMa5+wbaSuwprYc4uEi
         FUKxxdArznBM66EcWk9sE0iPorYYB1lbWPJwEqGW3SMa/osFVije2FzTCXItK5I8OfPR
         WG+fq1LtZkp/o6g3pZd7lKSc6jhE773tDVpAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753160314; x=1753765114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zUf4AlEkQu4akq53baJqj49MOp0hPw1pbtMFQqaD0kY=;
        b=nPPOJUqBo1WTkheYzRjf/KTFik3R92Nk1+FIaWyna6vZulUSioDlE4N25AysctyDTL
         tK4sj3saQcPcLMCXJVMG7l/G4k+Da6WC8U2vTm5hTE4anYYn9gSou6HN5zLHZwEOOwsf
         ALoThEOeCkie0FI/mggKdx6JkmMJPEUWvmIfzzfGGeSlo29pdij9eOXCMUlHsD9+1Fin
         wMZUcmymp35Fs4a5Ls9tHNmyvuq9WstAqdY3UDPbVYNb3TsP++lVPJhlWo6Kyp1ElcWp
         QsYnUQtyngaYaBOK0LHyBcLqGDbxlktt3wStCbxBs+SOgIMn0leLly+avzNR0v96GUoa
         qv4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXgzmTQuu65+E4YjDILC+pBsCAUlNr3mbEZtdN0FazmvaGDYYpu2jltyyd24ahfYVeXi0uX6PP00YhVAJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YycTbc8tN58t90If1wkQAkE0nAXGVDBF1WN6G+ee+McDk1kgvd6
	uQ1EFhe5uYhBeRv2HpXcrPI/RuDKFJqVC4/JbMp/bs0KsmF8IA/pWDcQNY+oOi1Jl3S2rdwW+6Q
	3DfAgjrISQ44LOgpmVGOWqQ150r7CD+omaQtfmDjv
X-Gm-Gg: ASbGncuJlhKQHC1Hprzl7GI7Er6qKlkaWyMvKyLrE51MM42Q6TV4ApHZr87AQjbEFh/
	7QX2ziJsL8fEpKRg3agiEU/NhKSeX37K/ZI35FcBTJXLS98EU9J58pIjXdRnzaYHUCoiv0xI4z8
	iQhPrQ40HKFhS3YgWR34r7krMVQwp2SMiw1HKOylqzyHNvUlrY9HXteFZdpX+CCGmy0BkKqQdsQ
	w2dUKCnPKOtCtb9eqMKlzl+6FSnhv2tJJU=
X-Google-Smtp-Source: AGHT+IEyU+tFAsFMORjYCQnykMeU/pbwHrSE3Y7T/aLBjOwuzBCNRlXwUTyFrlR8NysXmCw/f9p80hu9ipZkTsFJIJQ=
X-Received: by 2002:a05:651c:40cc:b0:32b:4521:73d1 with SMTP id
 38308e7fff4ca-330d260dbc5mr3824561fa.20.1753160313915; Mon, 21 Jul 2025
 21:58:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715140224.206329-1-angelogioacchino.delregno@collabora.com> <20250715140224.206329-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250715140224.206329-2-angelogioacchino.delregno@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 22 Jul 2025 12:58:22 +0800
X-Gm-Features: Ac12FXwqm1vj4VltrzTTMYOVI1lGXo2qDa8kdMFLAUiRJFcrn2uXXat6X0eoKOM
Message-ID: <CAGXv+5FXr-mGDG4mfqFx0o_dhi=Q3s=Yjpj79UVfEQKf2Wit2w@mail.gmail.com>
Subject: Re: [PATCH v5 1/8] dt-bindings: regulator: Document MediaTek MT6316
 PMIC Regulators
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, lee@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	lgirdwood@gmail.com, broonie@kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 10:03=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Add bindings for the regulators found in the MediaTek MT6316 PMIC,
> usually found in board designs using the MT6991 Dimensity 9400 and
> on MT8196 Kompanio SoC for Chromebooks.
>
> This chip is fully controlled by SPMI and has multiple variants
> providing different phase configurations.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

The descriptions match the datasheet and design notice I have.

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

