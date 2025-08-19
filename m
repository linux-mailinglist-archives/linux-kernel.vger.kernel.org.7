Return-Path: <linux-kernel+bounces-776040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F211B2C7C5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A101189764A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D346727E1DC;
	Tue, 19 Aug 2025 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqHSshAZ"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E695D27E1C5;
	Tue, 19 Aug 2025 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615397; cv=none; b=F7aGjJVtB7vPkF9zosRUUvhrSpEg2TMStPJLCqkqfbJVjttMpIxKjPKdhRMmIi8iFSqu2kFj0UtjvSjy01td5z1qg7gXd3paTOJcWdF82dnJcJhc9tNFgI0wXRQO+bUrzz1Zx3NjTr5Jt7WeJlmO6k57n+oQMqojkQ/27xkSrIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615397; c=relaxed/simple;
	bh=SxK/8o8TYuy9PyLKW/7vylp/E9GnFz21EyXlXO2+pIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g1jZms3rjSgIT1JGCgBh0xA0HC5JXFtSNEuS8M4gmu+DCWUNoF93YkmCZPE8cGXQs9K7AZJBF6gL9Xx8rmZDOaWVWP5CNZfbBsY4f4/yBhCm5tgM+KRnE+hbKJwS5doTZ62p5+QNsn9YpZK+m6gmeKCQ3FWC9Pp1mDSaRfRRR/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqHSshAZ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32326e69f1dso5748376a91.3;
        Tue, 19 Aug 2025 07:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755615394; x=1756220194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxK/8o8TYuy9PyLKW/7vylp/E9GnFz21EyXlXO2+pIQ=;
        b=RqHSshAZbKLGcfkkvdGcxqFTyiYmFIjWkXpVD7tWP7PaRHS1+zFoLbc4UVOSgutucA
         MD9ornLPqV8e0ORPDUMYOAyIPH2jU1UuMUeaEop3QwrIAUydz6c8kve5HQhfF9LV0Jtm
         Up6U23r1GpEJuI9auHAYjoWPbxPt4v0BLNLRrLlbYnrW+wr3xQdG+Lm8jzSBMrYJytvf
         mrtaLF8wYggM2sVm/9K/Dbulp+0Xw1PQcbpkgU3uHlC+1KrdPSELQIhKa3CVO089IJrH
         Q2grut/4+XAvRWqRTtYxnMOZzWsr1JxP/LKJ+5uO+AtK4j/KZaoGy6/lNizvUWmv9Fka
         vcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755615394; x=1756220194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxK/8o8TYuy9PyLKW/7vylp/E9GnFz21EyXlXO2+pIQ=;
        b=F81/1gwrCY4UTgtuMgkoU7oWWrjdTmJanWuiKL79Z39Uw+LErLJnP46vj5r6ETuLjc
         WoY/jgn/YQpQN55T3KTJ2Snn/GTuDiKzCS/pKcOwytKpNkocoyswBbqsnV0QGE0i9w9j
         dawsJM6hlZbmKxKbBTgKgrBd4qP25wy5cPMAXhHIBJhaprIo1xxnHNrvGlcw6v8x4RU/
         lnButha1yIqZoIAD5PCgeWJmkERM2n6JjrGGRfE2MRGdiqAixUCttyPnfeD4OUL0xJNC
         uq40+vBYbERGrady+hzG93Tt/oz2aqYRnOMNeE1bdeEJZSHdGK5hUc4kYoTn1aoU4yMK
         9+JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhBZ7v1lZ7+dr2p0NenCdVBR9u7ZzPAyX2A+21/njX/nz0mOSbTn5dHtF/vTSsvvuksYQzmD6y5GlaXThn@vger.kernel.org, AJvYcCV/2ZM+L9ftCtHsebDOPYhCjEjeH3bcwmQpTv57dwRnbsDJqJqEWiJq26J7AV5TqvCCyFHgUjOqMgGg@vger.kernel.org
X-Gm-Message-State: AOJu0YymzGAspH9YQ7PwHI72RJM4qp1ML6yCehulTBSv5tpdZjpqAHZg
	9UvcNrsC9lknU4gwGg2aftfWloKv0gHbOvdDECu8/9fs9Mj49vA7csHfISQFz/qDffvYz0nl5ob
	3Sn6ZH19yE95l2EfTMWjpV7IxbYrwPlU=
X-Gm-Gg: ASbGncsHsCHtvTLJLh1stVlzjHIFgfPOzQMPZvo1IJL31PgMFWYUblkdv1BRWgm+HSL
	v2tFwk+JCh9Zk+TyWqdPdvNBXDJcz5k3ky8U6K8Rb9Pf4+8J7XWfpil7CsGcWX1wvnZ6Yjjd0e+
	QxCsud1TfVWkc9/aRwSXcUwDp++QoU26d0WkqcJ4JeTwRTvb4GKhjRbl0I8JHu70lINSr2QLSZF
	LfT3FRA5CUxHyc=
X-Google-Smtp-Source: AGHT+IEpjmZ8XVkcuZKfCV290Wvmbyt6Tv4cR0Fg/t2sSiijLaZh9EFM7KMO1OHNGRVKT1fRGi1Jac5EIi6kT1CFbYs=
X-Received: by 2002:a17:90b:37cf:b0:31f:3cfd:d334 with SMTP id
 98e67ed59e1d1-32476a1d6d0mr4123679a91.4.1755615394148; Tue, 19 Aug 2025
 07:56:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819131800.86990-3-krzysztof.kozlowski@linaro.org> <20250819131800.86990-4-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250819131800.86990-4-krzysztof.kozlowski@linaro.org>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 19 Aug 2025 17:58:45 +0300
X-Gm-Features: Ac12FXwVQ1C48dlhpVxnCgyHSgql8U6XY0RR1RKOzS1VLcKJpTIqytqaU50CpkI
Message-ID: <CAEnQRZD-Ph+HUWp=X50YcaU1LRbz3KxJWopBRt7+3RQnG8oCGA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: freescale: Minor whitespace cleanup
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 4:25=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The DTS code coding style expects exactly one space around '=3D' or '{'
> characters.

LGTM,

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

Do you have a script to find this kind of issues or just manual inspection?

