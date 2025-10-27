Return-Path: <linux-kernel+bounces-871275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB75DC0CC57
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 950073B79E5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52D62F39D6;
	Mon, 27 Oct 2025 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlpY9PJK"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78E72F39CE
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761558815; cv=none; b=soKGBwgBxcs0lqaTAmp7UP/aK49qHLiCfWIoD46BaQYrWPvtjFCv24wyWKR4Ac0Ba6lWNU6AlcAy88AdE/l6rrcN4gNJ1rfWtAAjweD+Oq7JoV5m47vfoqtah/sjO1ID/tiNxpoUciyJmPLKvLBDvIo+ZZA6VdQLbQGKCOzTwG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761558815; c=relaxed/simple;
	bh=uHZIvBo2w1MTfQAp1MbdkxhqheGGsSeb06hs1bU0eWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1G/Ul07PmQpumfnk8mFEcydzEWT52V7eiQQBBdNVDr1CKB4v4fT0/DtxEeAC+sSLOmmELC7f/o1whDaeavsEzIzsJi1s7VRAjDLj8bOAz9W4boklX3l3GdMijv9fYa3qmCrCht2oRejm7GjwGlPnIWCySkZj2mTj9nIE+TSElM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlpY9PJK; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33e0008d3b3so4438907a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 02:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761558813; x=1762163613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHZIvBo2w1MTfQAp1MbdkxhqheGGsSeb06hs1bU0eWo=;
        b=HlpY9PJKpXoOw9bpQk/Jn2/oQXTaHngwg1iB8FfrSBzs56KS2scu7zIbEtIP0X+N2T
         LoP84Kf2ucYUT9vWrd7iWmm7YbVy6FHam5D3XTq6TUAejwR31yW+tZ6MpG7kNV1vwp/L
         4AwUuV51ozl0qusm4LXIgdHzHGM0V2FpH8mmRblcjFeLNCk5NvLWaigJN/uddS2NpxXs
         0e4X0bFnw5lx9Rvm5xD6WeGPRIoeV39KR2Isidorw8oXMI0L/BgFbGT77Fg14Awu/oH8
         5rdOj/9M3ca434CGgsM4jkd7gIQTGP1T+YnVokilN2RCeoeZefbbva0OVPzsRNIon5VP
         OxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761558813; x=1762163613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHZIvBo2w1MTfQAp1MbdkxhqheGGsSeb06hs1bU0eWo=;
        b=AvwgEBg2JT5C5PXeSQxm1dKHHpV3suJHgfRWAgz3Gj2p44FberGtG5SXKxdyf16ADZ
         3PodZdFDk2IknGOcvl7BFhoxFH1v1BiGfE2cvYmiIuaDkrbFnO4U+iOS7csMdGAUQShL
         +GI4mfT+ldZIEP+h65NjaUa+UXV66sHRXItlElMm1yojEfTpA3idfUAc+11TA9RgaW9F
         TJD6hh1vB3pUEItt9h/e/eodCAKJ36ahhIhm8s4A9uUL/7kFY2e7vTVqlpWsoflTE9SA
         NYlHi/f1UoqdpDCDXaHRZ91u7naZF6bDYkJLdL677py+NaLhbLGt4MevqStb34fGELCV
         O7Sw==
X-Forwarded-Encrypted: i=1; AJvYcCU1QSIuZpZwlzuU/L/00vL/n2FrpwMwBqGOmOywdSfd1CLuNyUUkq374ZAyF8PSxHF1zabOmbSbA2lpTHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+9by+UYfkCiO25/DpnyF25ZIzIcSa3vTJpcD9Sso8Qz05rw5Z
	u7tbbnnciScyi0K/BzQ9CS4rvhbmYdZSeNOtKWiSWnPOq9aglk00i7S4AOMJh9MrlvsAvPHiKra
	oyJ+lKi0JIVypA4wW8Ok9Wgp+TnvQw4A=
X-Gm-Gg: ASbGncuUrzp1r9ADb1QevD8Obo5t8kWua57a1F5qVQSBeHvqMEfS4Y0jNG+uak9D2sb
	wBbhFCqvRvTSScWmGhikOKFrGcYfVMMX602EyV+LdEUaJtQjK3mzN23OvH59HKDnRBaTAkjkpGs
	s7/BPUrvZQV0mMl7FRYgYeUtRHLvGBZ8qHg2P6rH+D2hrXU/awmCe/gRXnc2z8ypPcPTxhhytFx
	cVE7IY/vX09E7mxnVDI/aP6NML6bPAHI6hCUzVFYfXv0vZUh9sDl3fKSmePg+3WEqMf15VcJ+I1
	ZFWbu/kRZnufb4z2xPGfmU/vYST7YHrWSZk=
X-Google-Smtp-Source: AGHT+IHtoK9BtAWkuBlb8wHMY81e3C7F/tuuKHdZ9dReVXpNyDrBKViu/Dmg9ERnj0atAtepiwCmQJhoe6CLgiAV9x0=
X-Received: by 2002:a17:903:38c8:b0:26e:d0aa:7690 with SMTP id
 d9443c01a7336-2948ba3e147mr140058725ad.41.1761558813104; Mon, 27 Oct 2025
 02:53:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017112025.11997-1-laurentiumihalcea111@gmail.com> <20251017112025.11997-3-laurentiumihalcea111@gmail.com>
In-Reply-To: <20251017112025.11997-3-laurentiumihalcea111@gmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Mon, 27 Oct 2025 11:55:58 +0200
X-Gm-Features: AWmQ_bn8djVWD9T3hbxz5BaFzJdgRNmgPK4MMnk5oMPTdlZh7IbRd6rHqy4Tk8c
Message-ID: <CAEnQRZDXhb=ssjbL-SOWXN74pjqzKgwXQ3SUUaQYMJapRPgKFA@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] dt-bindings: clock: document 8ULP's SIM LPAV
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Daniel Baluta <daniel.baluta@nxp.com>, 
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-clk@vger.kernel.org, imx@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 2:22=E2=80=AFPM Laurentiu Mihalcea
<laurentiumihalcea111@gmail.com> wrote:
>
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> Add documentation for i.MX8ULP's SIM LPAV module.
>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

