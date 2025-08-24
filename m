Return-Path: <linux-kernel+bounces-783765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E00B3321F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 20:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245D118985AB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 18:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7CB22577C;
	Sun, 24 Aug 2025 18:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="KAnteFgP"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79E71EE7DC
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 18:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756061686; cv=none; b=qUHoXQAovzUqFRc59h72ZHC1tlCSKXlpbg7vQxeTZNmzkQEnltsZpa2l7Z0C4cN/tQLNOLa2ExD36nCCvdcoE4nJKZ7b2AlT+xbHRQTbiKwsgbP1z2RXBUQuPhS0I5M89AY3/f1lWgT9zWD9t2LUNISNE2fCXCnBQIE8ueigs8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756061686; c=relaxed/simple;
	bh=Su9fVUmbbEoXA8/x3VGnp+xHkiw3aMwd14wBtFK2re4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Q4P9RZ4G/qShKb1JILUh0D6mOv3z2p4usyokeVrb/xsKpOFH4z0Z+QH7BpDxLWjPz46nNM+DyunNMzU+z3Qs3YysEyZDK9r5jWaAH1ddtWjqUlYmG0EAVAb2VnJ7UP/pw8KfhpslOf3kOnWXJ+FkcJE2UWaEuhCzEy/fNSHX3g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=KAnteFgP; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-770522b34d1so591215b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 11:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1756061684; x=1756666484; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4RBQN7ZcwLGgu6eJi1GMF63RINzrO56jY30XvA+HQE=;
        b=KAnteFgPDSGTz26iIkVQw/jDko6d+xAfJu7Mz+i+00lfj7teIILln3TyuPzphcj74y
         JIkTWogK4q7HkXdVZImvjIWHmE9AF1inJ412jgvbaG96Amp7dFl841ZxQeVE3A2gzz9u
         jGSlmB3WoLSQ5RLVrWZ9X3XrfOlyfGBK6hoBuveoLuyPhhxbQUe8ooVfmT80fQoTyNjP
         caNDC5oCt8Ms0podkMrCZa6BPS9oWV0SsNmuXLGoHoWODVMM8KbqABNqj9gmqmQSr47a
         NlP8+bQH5jtMGaNAyBZhf3Xv+XUdobo/SfaPZgAIstVrygprHOIzD6XVM0Ab1Lun7k09
         98gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756061684; x=1756666484;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R4RBQN7ZcwLGgu6eJi1GMF63RINzrO56jY30XvA+HQE=;
        b=l8kOyhb+DIFJ3bG6rfT4ZZ97iG4Q2d17aopGzh8uXdflWFjr1rWKJjXCMixCCuli5n
         c3R2Nba5MCn38huJPl7pJucGrh4YrNuND8UT/RPNGWB1wi01MzS6D7cx5HO0PgY4Hvvi
         G4RTZEe8XIJjO0xlnuhonU+xRAagsodnP+ZfhRdJsDyI05xV5DGzOu65PDwnbmLUGOQ2
         UZxzfVhpjFDcJKShgQeaUikrVqofUyEXOHsow9y3kPQ7mNtccDkDrgy4Sq3rbp+S3e0d
         XxTcKrvnqUvJRIJmWibStfdfI3DUb9eSK8l8ffKKmWm20K8iU744FtNLW48C1yudS7P7
         kiyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXE6brEXXaoAAT5iPza6nbdgUnMYa4KuR4tiNK/qETH2PYoxt5Rzcrdo5GWpELvCcBjQtQA/wZkG5XQMTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YykrV9l89e9vWN5KiAI2o9txo1NgCyUftuCgDqW0MSdrjEe07I5
	0mj5/R4MWQazYrHyY7LETOlkA0sqzF9JLMArqf+45ySp0iuRC60gE+pjVx/H4/38tqw=
X-Gm-Gg: ASbGncvC5B3fXcoM0aR+CdWMEKs3gd0aEVRUYYak+EOCbrFUAvn4q/oUmLD38GjzUyE
	DcK2OlYodBizfiPMhAm4ZltF9zeyc32Fbo91iAo43DlMMbLuC6BfIl5tSiVn1xHRQZGq4//UbkJ
	OQXhx04wqgKNeAgzN007QZu0dmL3p6t0w20U3QTGwT8Fs1axst45skRLDJoym6pQmWala1d0FD4
	4Cpk5CJ55rj3JmVNhrqksbK59RigwQapQ4ix92lIBTyBpKrV899QJh1icqOwbXY1g2iYZg4pUwK
	6sUC9S2UKh12aCq153H+eFTtvqeDRSxyipNph6mKz6legz+q9eeFIS8dhL8molG+fTrS5RlDHZV
	Um7cMUKNsKHmULc/ttMI=
X-Google-Smtp-Source: AGHT+IEDk7at3Bpgbpj+v0Eh4vjn2DF3yviRYYO1YRDu0NiWwlKlGxDy4FGz5GLe85FB4ML7qbBaOA==
X-Received: by 2002:a05:6a20:430f:b0:220:898b:2ca1 with SMTP id adf61e73a8af0-24340ddec04mr12861606637.21.1756061683987;
        Sun, 24 Aug 2025 11:54:43 -0700 (PDT)
Received: from localhost ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401afde8sm5257723b3a.61.2025.08.24.11.54.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Aug 2025 11:54:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 24 Aug 2025 12:54:41 -0600
Message-Id: <DCAVWVJ990VS.255346CDNF1GK@brighamcampbell.com>
Cc: "Neil Armstrong" <neil.armstrong@linaro.org>, "Jessica Zhang"
 <jessica.zhang@oss.qualcomm.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Douglas Anderson"
 <dianders@chromium.org>, "Diogo Ivo" <diogo.ivo@tecnico.ulisboa.pt>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <kernel-janitors@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH next] drm/panel: jdi-lpm102a188a: Fix error code in
 jdi_panel_prepare()
From: "Brigham Campbell" <me@brighamcampbell.com>
To: "Dan Carpenter" <dan.carpenter@linaro.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <aKcRfq8xBrFmhqmO@stanley.mountain>
In-Reply-To: <aKcRfq8xBrFmhqmO@stanley.mountain>

On Thu Aug 21, 2025 at 6:30 AM MDT, Dan Carpenter wrote:
> If the mipi_dsi_dual() macro fails, the error code is stored in
> dsi_ctx.accum_err.  Propagate that error back to the caller instead
> of returning success as the current code does.
>
> Fixes: a6adf47d30cc ("drm/panel: jdi-lpm102a188a: Fix bug and clean up dr=
iver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Good catch, Dan! Thank you for the patch. I'll try to be mindful of this
kind of logic error in the future. Please let me know if you have other
suggestions.

Reviewed-by: Brigham Campbell <me@brighamcampbell.com>

Regards,
Brigham

