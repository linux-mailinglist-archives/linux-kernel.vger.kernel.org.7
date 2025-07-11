Return-Path: <linux-kernel+bounces-727805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F32B02001
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2AA56513E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 14:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F055D2EAD0F;
	Fri, 11 Jul 2025 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="IId9Hb+A"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22512EAB9F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752245901; cv=none; b=YmsCgiBuXo2PUVdH0NvYY3syt7U7inH/KwZEGe9/ZrVGodyfsFSglb6Mxyt8po519UV+Ej7HsZvJFxuaSFmnpRatQ1XPG+FqNXvSkCPsGFdG3u/xEvDbwQu/jRPOZa6FyarCWYqqfO0h8F3DjXePduhWfSQB0dw+J+xnJdif1fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752245901; c=relaxed/simple;
	bh=Sya4IZecYhktVtfCvUqQruAjlPK6WvHM6B90iSMN2dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kjKj1/HcLERx55EGpj2iLhZX26pEQzvuYSPglcXarxl1MaM2A4FZ+zI0EUb/ZYN377Pq9v0n4j2EZdWlOkupSDYAfXNTYxiBV351/KFwtVJl5kX8/mHbPIbmLcDaNOwv9Bsy2uaWPA3j54qMjQlcjjeGdIJgUxFq1CNU0oWHNKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=IId9Hb+A; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a5851764e1so42643611cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 07:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752245898; x=1752850698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xpLl3JD2OmKi675SUm1Nkl7pyLdcDBPv23avyh/9xc=;
        b=IId9Hb+A/p5KLntqBo8PCqBaELxv7TM8Xq5Wpq4NTGR6uTZyDHdUq6jqKU8zq3PlgZ
         35bWi2+DQHYJlvFghQlFUTxlkg2lyO/rH58DPHm8vQESsFtAJtBJ5t/oIL+2ZuXsuIFs
         RvBUxRXCRGZKM1M/Lxo+gpXIp+o/7pEUkTqEQ15I4kCF5yw6LPU+M3D+72DCvUc8ynde
         YYsxh1oYDPvl2CMN7LtpRdb3OW89ymK3nTtbmLNyA/LF5G4tufQYP3fHtq49Xr1v5RD4
         k5jEJeNREiAV6ZVRi3FUP1zYAVw8SefwV+3XiRh5lIj/u66tWNpMKpPTata1nWjzJQHY
         xJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752245898; x=1752850698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xpLl3JD2OmKi675SUm1Nkl7pyLdcDBPv23avyh/9xc=;
        b=DXuZpyU8skaflryPes8+wUmbsRYluckoKg1vC52D+VEcRAIgBTh67Y7qVnhdZ4pJ1T
         kXityL7dD9HU0QlDXLSRW2cpIRWTa8dq3S8sM5DX4KNhTH2w9huSBRlahcADwZcCL/Sy
         JorhGPz7yYuVwa5kg0zvTcWAVwLC5hstepx02ssQJNlnrcg2ScUzHu6iY9Uzay5YAotA
         qOPO/JbZqSeO9CjpgxrtBazZpF7+WzerkA2WssgNcCOQ03IVFfj8+yMU9iId4o3Y5TRb
         rL+npprs2asc4kLIibIHs5A/W0WNvpfGqMREQ+RpRnJNQ2F4bOw/R7QjyGJ2FZSuzJqi
         by4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWM91G8XBM6s91xjSAsYkHtUvhERmFHqlmO6BiboFKl/6/VJA4xVbw9atUVaVPWcVKpQ3/TkB6AifGQyVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvb/KvMKVGKXgK2/xMvjg+VzWCNSSME+Mdr3OGwNBtkS6ZhPmH
	ItouuRQFuFZ3yY9214vEr1qFhi41KSmPfbPcK20kK6mW0KuCqt/GA80++y4dUFA9z1w=
X-Gm-Gg: ASbGncv2L0d1DlMbheV9PIGUuI/mVeFnvgQE06vFYrlfKBiqtS5fulhODlos10NAwOB
	3FPF7eOs/KIuybuzk7yTBXUeE4WPS5MmlEfiSXY/p/XVubjI8Y+eEG3x6W3s0L6dQM1ruui/8dW
	NT6agSSfNneVp+WhJRjA7H6tULC6+dfffWN+nnnB1/ePQWusAT6W8A6AT8TK9simQNNALj1oMFM
	7Zn959+JEtlmvWIAyRRRmEnflRRGRMt4t9BlqkZAvLM1VMXiliEuVYLSPoqxUYAKBonXndU8mrz
	ciwCauFky1yCANBBQuqa1FhSsx5cgFhZx1Nl5tML++CTGOCCPjt6MCM2BB5at3vAKnaIhDiFeGI
	AxFOl25RvA37eh2UCN2I1Zder6jz+ArKNIIsArJbIqFcVAkX8TDxAoJuDJ6DLt43HlnKMtTmc1n
	E=
X-Google-Smtp-Source: AGHT+IHL89Heh4CdilUF5hG4UKz4fj2b51QwxhHDN537ydTZFAi50FvMeaNyPPTH09uspMZNgw10pA==
X-Received: by 2002:ac8:5d0c:0:b0:4a6:f6e6:7693 with SMTP id d75a77b69052e-4a9fb861a08mr57831191cf.6.1752245898221;
        Fri, 11 Jul 2025 07:58:18 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9edc1b784sm22118351cf.12.2025.07.11.07.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 07:58:18 -0700 (PDT)
Date: Fri, 11 Jul 2025 07:58:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Li Tian <litian@redhat.com>
Cc: netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v2] hv_netvsc: Set VF priv_flags to IFF_NO_ADDRCONF
 before open to prevent IPv6 addrconf
Message-ID: <20250711075814.1f5ae098@hermes.local>
In-Reply-To: <20250711040623.12605-1-litian@redhat.com>
References: <20250710024603.10162-1-litian@redhat.com>
	<20250711040623.12605-1-litian@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 12:06:23 +0800
Li Tian <litian@redhat.com> wrote:

> Set an additional flag IFF_NO_ADDRCONF to prevent ipv6 addrconf.
> 
> Commit 8a321cf7becc6c065ae595b837b826a2a81036b9
> ("net: add IFF_NO_ADDRCONF and use it in bonding to prevent ipv6 addrconf")


Should be Fixes: tag since the reference commit caused the regression.
Yes, it is a way to blame and track.

