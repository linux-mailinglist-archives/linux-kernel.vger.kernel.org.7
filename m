Return-Path: <linux-kernel+bounces-863517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F13C4BF808B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 941224E5C33
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3578734F259;
	Tue, 21 Oct 2025 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="upxYl89n"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3740221FDA
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761070925; cv=none; b=tWDf1FQSI8+z4Wln1Bsy6amYxAb5yS6/g656FLHGNwiGA4c53HF9Lg7pyRpkcXPtPwRXj00YcY3n72nO0anFONuZBnvGsyFqb37l247amSfsOAXw60ns/T/SVjfFjt8zYyVY95ovCSNU2xCyKPOQl86dICt/kybh3fiEf5043OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761070925; c=relaxed/simple;
	bh=79ji3lRxCDVH2zpvzp7RBs9o8422wf8mQPe676ijU8Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VY+Gu12VjGcZMA19DphheyzXFSaB+FCsenNh2I9WH02SuS8OoHgWXom0+bKkr0gB6STTiPVPJEK2FNAqX6oFXzmpmOMfDwRXNyws6FQ2xytBLLFrurvU792zkJqqhlcRWgYjoaeD7OuRsNQJ+CkyRnGzBS4hDbGC0SdPOCEgXt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=upxYl89n; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-93e830d84d6so390447839f.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761070922; x=1761675722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hwb5AIrReUvMBmNj6v22zzS4g0svF5NEcsjcLOGLDJE=;
        b=upxYl89nX7S3ZT4RtV1vgms/KWj5gS2hsHQGpfQLkxcw6RWrCZXdGv1AyzITSsffGz
         wao/gn9BaDEVK1gb4SN96e7y24ndTldRbTUYtf7nnqBn/BbLLG2Qs8yft83dA8pl+0d8
         IUTSycmJytvCwyaqO6BRSzRD/p9r0fByBJec9B27Dp2pWE0ZOF7+akUTgUs3OnIIxhO0
         3vBCzalSH6iOEtW0MIywa/Nih5hg5j+oqQb+Et4/bGJv3KUlYq6tABwyv41mdf0/Ukg7
         BAQbtxGDTt5pWxtOElzX+jClNHSwsZbU5D86FUAwWqZCiBRb1/Ptz2rtAt2OJ5OPWj8H
         Toyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761070922; x=1761675722;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hwb5AIrReUvMBmNj6v22zzS4g0svF5NEcsjcLOGLDJE=;
        b=TcB1Dk7Dle7ViVoaNT9LqCVIBckzM1WRUimk26cgOHidEydP8WG5Cvo8CyPcQMIMDA
         zEQkNgscYR0ox9eivjWrhcPjVf8jzjYt8LwddV+HSUQ30A2R18yKV6WUhu3S5iqwc3nq
         eT6CDlIBiHmCF1sitwHz+dUmpv7OfadabzQ/FVOf/oJILUP3AbvJ0oBdkTgrcOhF54PG
         EYUP8456yMeOoSzS6Q5ZJRpjiSPHASPXuWCxiw/sFyjfdE8SM6GWGG/jjnAXoHNKF/TX
         M5tucVPVFCdzVHyOSuDeh/gou8jJH41MT029folPwCBO+pKrMVQvuv3dBxkKlMdj1pSu
         nSFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQ2Dfga7hP+MMs/dd+7vIrR6Uyi798PbBcIlgONyNRkAScu3dBjdkBh83z60K3SryDuGnCc8/wSMRhgV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGrPwcVmXOm31Sy9a5E7kds4QiMfdDUe19vfagIz9BZIHQ9C+6
	70iSXEVyAm6kZezK1MZecTsS5UN5Mtru6dZMM+kd1Vdj8LViTKb472a+RlC8bfwzppY=
X-Gm-Gg: ASbGncsXJb2sqoNXEAmKCbc3xnxOedcbbYjbMdKKanClJjr001Q6DbeHAti5GxtaZSR
	04nImlQ4/HHOzXqTsWW17FQ1f/TfZsD2Y+yVLct/Krl8g8T5dRPRfx2hCAQ7jX7wGYGg0Oqp3Ym
	7c1fyr4jB87suPURZgayPLPvNLnUk02Xc+Ls8eVnOx272xzSvINX5PqWuw4brH2O5TLrOWVOObh
	BnhirQMUdXoCM+ua0g0pknwtmuq9r8o+RZhxaOHBqviKeGici6hrNLr6Vpp4AM4n4aaucckftX8
	NYkSc2xoh9LXSxA3JRtm/XfK/FloH3mfGDe9zg9jETGI2PqvpNNGPtUaUtL3Nh+aj+XDp+RLq1J
	OoZn/8TqNeQqSAquUoGLMDZd3UI3bFCrNVDOmGK4XMAdpUzCFARJbfxZV/YSDqCcmFiGlL5t1TD
	hHyA==
X-Google-Smtp-Source: AGHT+IFgvS4Hrtx9ZCCqnSX34c4rLtA7kZh40GCk23wzu2Dl6Bq3N1MD4Xw6Te/SetuH8H3DDeCNtg==
X-Received: by 2002:a05:6e02:1c01:b0:430:a14f:314c with SMTP id e9e14a558f8ab-430c5205699mr254831015ab.7.1761070921883;
        Tue, 21 Oct 2025 11:22:01 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a9630a45sm4346361173.20.2025.10.21.11.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 11:22:01 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ranganath V N <vnranganath.20@gmail.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251021-fix_indentation-v1-1-efe8157bd862@gmail.com>
References: <20251021-fix_indentation-v1-1-efe8157bd862@gmail.com>
Subject: Re: [PATCH] io_uring: Fix code indentation error
Message-Id: <176107092101.199360.7637020500608445837.b4-ty@kernel.dk>
Date: Tue, 21 Oct 2025 12:22:01 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 21 Oct 2025 22:59:30 +0530, Ranganath V N wrote:
> Fix the indentation to ensure consistent code style and improve
> readability and to fix the errors:
> ERROR: code indent should use tabs where possible
> +               return io_net_import_vec(req, kmsg, sr->buf, sr->len, ITER_SOURCE);$
> 
> ERROR: code indent should use tabs where possible
> +^I^I^I           struct io_big_cqe *big_cqe)$
> 
> [...]

Applied, thanks!

[1/1] io_uring: Fix code indentation error
      commit: ea3ba56a6f0b66d3e6cc01692d5a83a6d96797bf

Best regards,
-- 
Jens Axboe




