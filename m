Return-Path: <linux-kernel+bounces-750039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E13AB1563C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 02:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6917A547912
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 00:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCC335971;
	Wed, 30 Jul 2025 00:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="dD4VpW8g"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6581D540
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 00:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753834521; cv=none; b=cQeAFyEIcIujrBDXSzTtDgX5OpoVHYddaa8Vr0mn7OeOxoOhUXQK4JE4gtjyIQ/iijkOdxJXA0REQtcOKcC27MXPwQMUCYrXEb7mD+ZsPDE5RLh0x3LFReet1aX8/eRTp4tK2xAgp1JM9HNgLN0XB/1YmsR9dUF9b1DOurzA9iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753834521; c=relaxed/simple;
	bh=B7mZ4nEVKbGQGNfr6ook2ZXrLnFiuRpQgXmMMoue3C0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=R/wTpXlDcKAdSLdgqXiHcrXScJD6S0w1tySCH62+QgJNqE7acj17jP9eMtqCs9k11vCXEe7a0cQkINlZ3ZppkODvPgewRbVNGcGINOEFsORXFAVBKsiMXWJOXIG5TvkUmUlAhaoNfk8j+xpT4q7I0ddf2vj75plavFpDtTZBmTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=dD4VpW8g; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2405c0c431cso19956295ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 17:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1753834519; x=1754439319; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7mZ4nEVKbGQGNfr6ook2ZXrLnFiuRpQgXmMMoue3C0=;
        b=dD4VpW8gl9dW33TTC6aBsngnjk17ZIz7msrwsVhiS8dvs/Q1ycK/rOaLXL4KjfMuyQ
         FtzLIU0hjrZPjkAkATEGItv7AD7c27exVD4xA1+M+lJZnX3SNtPxSla8zG8eavdd84hZ
         V2P1KhnM9pX9X6lb6OmKXAcDuHYKC6BV0laP/5GMfoR2K4aMzyBX7xDz7+vYE/glawh9
         PnCCD/Fnlg2ETz2+bGHyMNPPszMOIdWF3nQi3E9YP1LhW9vgOLFsKL+F3jOfrY3z6aYc
         PeRdyvddRoT2cGgomqx7XnI8Xcgm7HLEi6fkxXz3hNgSkJlyLZ8rgattgRph6vWme8hE
         cN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753834519; x=1754439319;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B7mZ4nEVKbGQGNfr6ook2ZXrLnFiuRpQgXmMMoue3C0=;
        b=GupNrTR7C2ihH75zPgz26Ulm6kvFIhEK3ThuUpJnMWwwLxZoCtS0TVb1oPbKpsSBXO
         zVoSf+C1loHatz4E4YQkLmHntYtBIkF+Zax5kJ35kfz61c0DuyFJIEjEfem+Tzn5TjbS
         Qx/j7oISGIqxx6TFnINf9EoSuHPxRMtOl7aXS24FuNYgzxOpGy5PtFAI8E6DC1Wkoje0
         9Zh2+pBwiEhPXbUxI/R+S36S/UjoNfsRnVxi7KQS60VX86rCAFIrbxLH9KWfaRdExYsP
         2IUInDS2qAlkOe6HRgtNUsNfkZuLMpwCI2hwuh2ptZLQm1YR5RTw/IN5amDAUmg5WRUG
         +ZQw==
X-Forwarded-Encrypted: i=1; AJvYcCXw8TSuzWeB6F0ZcQfQ24fenpgqYmN3x7s0zm6ca3IGrrk0UB/57oWw+6OF/uR6MMLV8fUSJh/YqvHGpxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuT/h/b7inw3JcbJ61Bfde6lLI6R0vPj3KfludWbuBi/UjxtPw
	acLPxi5npKryLoNJIPWj1Gr2cW+J3p+L+4LOxl7xSBGNwSgss/sSO9Nk5dHy7YP/wCI=
X-Gm-Gg: ASbGnctWo3+rFpL0TdzVCfP1Yu7WseUvzBXBeHvDFsx8YYBLKm6kYFRjbNnGgN1w1gu
	ZxEiYPl19QfCZHhDnz5Biz18xdoFN/+hIUv8JxtTs7gkTdpGtb85GS2eZGwQsc5ySBSiB+vjb0N
	pq18bimiv/GaAIZmq2Xto3Oz6oBmbAieIr+uIY4LvA2ZcxWGBwgql37+j8CbfpSB59entGCFYxX
	wCQqQx29CgzqXmngVoCjFY7MNV7DRCPgpU3juQm7/I1x9VHOennZzyu6TSF6fAm53JVy5F7yqAx
	HJuYznnh5aYQTvJwP/tcsVqTp7+AeCOC+cwbqAX61pbOS7/OQuNNCUoBox+qQhEpO8WaqPvcvof
	2T/k74Ya5drWwi6MZmRU=
X-Google-Smtp-Source: AGHT+IFtzt5MEl0tZciB3F8o6Fc5SKFZqY4YzGuLSUPsSrha4wOb+FYTYjRMuNTxbhYmOUlCfsVqRQ==
X-Received: by 2002:a17:903:3b8b:b0:23f:cf96:3071 with SMTP id d9443c01a7336-24096b48bfcmr17839525ad.49.1753834519151;
        Tue, 29 Jul 2025 17:15:19 -0700 (PDT)
Received: from localhost ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23ff7044135sm69618295ad.71.2025.07.29.17.15.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 17:15:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Jul 2025 18:15:17 -0600
Message-Id: <DBOYG6B6WLDT.Z096YHZGRXDS@brighamcampbell.com>
From: "Brigham Campbell" <me@brighamcampbell.com>
To: "Doug Anderson" <dianders@chromium.org>
Cc: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <linus.walleij@linaro.org>, <neil.armstrong@linaro.org>,
 <jessica.zhang@oss.qualcomm.com>, <sam@ravnborg.org>,
 <skhan@linuxfoundation.org>, <linux-kernel-mentees@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] drm: Add MIPI support function and macros
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250729054435.1209156-1-me@brighamcampbell.com>
 <20250729054435.1209156-3-me@brighamcampbell.com>
 <CAD=FV=VLoMenu22F_VeoHyfXwRO7JfXL8peQLEpkqeZ1tDOmEQ@mail.gmail.com>
In-Reply-To: <CAD=FV=VLoMenu22F_VeoHyfXwRO7JfXL8peQLEpkqeZ1tDOmEQ@mail.gmail.com>

On Tue Jul 29, 2025 at 3:34 PM MDT, Doug Anderson wrote:
>> +/**
>> + * mipi_dsi_generic_write_var_seq_multi - transmit non-static data usin=
g a
>> + * generic write packet
>
> nit: "non-constant", not "non-static"
>
> From the caller's point of view the difference is that the data is
> compile-time constant in one case and not compile-time constant in the
> other case. It happens that means you can _store_ it in a "static
> const" in one case and not in the other case, but that doesn't make
> the parameters "static".

Good point. The storage class is an important implementation detail
within drm_mipi_dsi.h, but just that from the perspective of a panel
driver author: an implementation detail. I'll go ahead and address this
and other feedback in v3.

Thanks,
Brigham

