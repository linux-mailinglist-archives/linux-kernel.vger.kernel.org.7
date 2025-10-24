Return-Path: <linux-kernel+bounces-868872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 143EBC06621
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62FAA3A5DFA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B338315D33;
	Fri, 24 Oct 2025 12:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OdXjOKxX"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F19307ACA
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 12:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761310725; cv=none; b=Py5dz7nyaQOuaGx5jyfEJ0MdriLo0zrhvzxZfgwAWXQrphy1xb3p8vJgyIT226sMtcPoSb8q7o22f9aEmQdgjxXX2YrAvzwFLfx9FZXnxLmzTaPAKmfmEN7dC+Z/p4CzZt+N/ibRi6nIt6wXrCZpdffeXbmDUdk5ZCCoRxTS0D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761310725; c=relaxed/simple;
	bh=zv16Kke8yqgjiJWpmjUKPrYOhlKmP4/uuWFc5yGXvxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lro0JeZhKEJpQZmSoLyMKfjjp7IzRSAzZhf1APoPWUvT7TV0srhKSXBUDjHD6pMmTuPT2Nga/njCmfxYvkXoF4N+Z0rBESG1msOwxsSpPW0bXULMXzRtvz8b1NSzL30epk9ay/4oIZ0XsmvUc03Jxqb9sjY1Zi5s7chp9eG/xjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OdXjOKxX; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-378e0f355b9so9521401fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 05:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761310722; x=1761915522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zv16Kke8yqgjiJWpmjUKPrYOhlKmP4/uuWFc5yGXvxM=;
        b=OdXjOKxXZvIBV9de8ZOXeQr67sAqD8PalVJQN/9V6CrcGlWfk/xqSvIQ5LzueECMSb
         OMjp1YaE1E9yF6afh2JZicjg8xuZLD2REAGEv010+3eisi6HowEihS8pKmUsJW5OE54S
         j14FiwNbip7EujObBIXuASlEJEDiI3dRL20CUYoY02/ksnjHRyss5IXL6akkLdtZSzkf
         ybkY4RCiuIpQ2xirOhqOAeWl6ikCMRXtUNboV1YXqVE/5hmKsIHmoL02TY3ZXr3Y3sIg
         q3WGiJz4YCObSeHrzisDb+hmkjxxEE1ghJ35qeff/tXZSIJFtAlLoiGZik4GeMNT6rag
         EDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761310722; x=1761915522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zv16Kke8yqgjiJWpmjUKPrYOhlKmP4/uuWFc5yGXvxM=;
        b=h+tAg/jFyKjSYkeu1v2rlLAhMsvgv9VTd1AIw2xVvzIpNRuakTOnGjt0+v1y6VtiAu
         NRaV2c9RCfXXeaE/xFD3goqwNncySaS62mtQR39x91lsiTVdPy0AyEaEGjYS+9pesO2+
         1ZskfP+ABrD8awip4wHkztlYV1s/BAxhkU2JUVdldo8qosVDsvOLqvfkrl6NcrD/s/lT
         6jIO5Lz20T2cW0Qysj/2oIsgu1vTMYAKbpMwa5Sj/0m6blXizgsPVhDLh57dKHAXybNo
         ke0gENtGonNbeXFKK/2UkppZvidZFO0ppEK6XA8sPjPbeofPqFIOGOUA7Tt1qsD8ivhq
         6jOA==
X-Gm-Message-State: AOJu0YyAR0SqJA5evXYmh0pKa6u0DDPMrNzJKhXRg2KXkIRIX+Gypc8m
	9S7AeAfJhuAacsbQ5Etkda3bcDhwWkA9mghcLBl0n4b/KElY4VXZsvAwxh0DnXpcfkaMZ8kTGz8
	NbnR7B9kISGpMFCur/L1sGgdry1RD3908q8C5mGxPoQ==
X-Gm-Gg: ASbGncsI7weOCU3pedWw2XsFRhAR2zlM7mbJjbhPBYHLenP5A8n6bW7XJ+s5dexEkRO
	N9Y3cz4oGuM5nR6Dz7HBty1Btatd455K+s/yvwfRMSIhD5csIZhcc8sFHPLx7jq9krD5MASeGLO
	wIG8m8SPZUp35/cpM7DvjIo9SXiZ4c4q+pt8FhdVI42CRnL/qIUrwB+PpuLsVumNzkm2uURFd1O
	QV3fE7hZ4WDVlUd+NkbJqGJxXXX5idtkSJsHWBo7u17iu4vnyogAYoZYfahIiZWDbixZdaQnvRH
	kSZCrrAADetT14Stww==
X-Google-Smtp-Source: AGHT+IHF9LkpNIRrlRpVu99l7ev0LdpwqQhfXRuIQZZ0ncl5gX4GTf5lVW8kJ+14MFqbskyOhZZ7aJPuqPi9SZUWgRk=
X-Received: by 2002:a05:651c:556:b0:376:5027:7f37 with SMTP id
 38308e7fff4ca-378e4518459mr6475001fa.41.1761310721630; Fri, 24 Oct 2025
 05:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024095205.123123-1-marco.crivellari@suse.com>
 <20251024095205.123123-3-marco.crivellari@suse.com> <dc2662f4-98b5-4fc8-9ed7-5e4a88168f9a@linux.intel.com>
In-Reply-To: <dc2662f4-98b5-4fc8-9ed7-5e4a88168f9a@linux.intel.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 24 Oct 2025 14:58:29 +0200
X-Gm-Features: AWmQ_bkaAAD-el4jxtvs6F6wp2vtCaDr3ajdRFuMESUH0b5iIQ4HTA0RNeg3HAo
Message-ID: <CAAofZF7FXixByyXm9fKo8aMjdD95wzaCanWbBV-cRzy5UYWTdg@mail.gmail.com>
Subject: Re: [PATCH 2/2] accel/ivpu: replace use of system_wq with system_percpu_wq
To: Karol Wachowski <karol.wachowski@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Maciej Falkowski <maciej.falkowski@linux.intel.com>, 
	Oded Gabbay <ogabbay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 12:49=E2=80=AFPM Karol Wachowski
<karol.wachowski@linux.intel.com> wrote:
> [...]
> Thanks for the patch. Please fix the checkpatch warning:
>
> WARNING: line length of 104 exceeds 100
> columns
> Also there's a typo "consistentcy" -> "consistency" that can get fixed
> with together with that warning.
>
> [...]
> Tested-by: Karol Wachowski <karol.wachowski@linux.intel.com>
>
>

Hello Karol, thank you, I will fix both.

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

