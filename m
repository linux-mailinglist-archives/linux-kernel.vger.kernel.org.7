Return-Path: <linux-kernel+bounces-892460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CE9C45240
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDD1F188622E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 06:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790A82E9EB5;
	Mon, 10 Nov 2025 06:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ab0tfpFz"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CAA295DAC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762757795; cv=none; b=Xj8kmq5rWwokcC5tZeRfm+bpEkuVg2TM7sKW5FcjrL0khpCMvv5o6cZp+qsf+D8CjSlUo9fxxK/trXM5RDSKtgwRM5LTQy7jdH523ZjKYouwtqiaP0h/cIb4mWdGJoR2EWgHIn3td2D2wM9fdgTsoTuHhK5zJVIGzeKI/qogM3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762757795; c=relaxed/simple;
	bh=1WY1CcuShlRk2we91Kyt0bCpaTxBq3s2lFYDIeGQFjc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O1jQc015+H55D7Qkhz3K43JcdyP7TjRgqIyEeg4y726w8bpE0p9ICyVMlenFcupIZKEqiPaBBqLyX6BuPiEjVmocsk2bDPQ9Ktj7UZb953ib3RWq1SW87I7hJThbZhYhFC79zo/dHNfQO/YTybGqGdiT5zdXKrKtk1rT3bkYo0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ab0tfpFz; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-343514c7854so2373604a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 22:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762757794; x=1763362594; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1WY1CcuShlRk2we91Kyt0bCpaTxBq3s2lFYDIeGQFjc=;
        b=ab0tfpFz7N8LEMnO9+dPg1y9BZlC+FL7v2HxxPeRaqSUgiD1fwyw36l0SaocrFfSxm
         Ya6zMe+cc2D5+aVpvHX4wMzFUzPNQJERWrXmdTtifhSIx8gHqMBsv1X+6ZxsIwS64W10
         EVGSTcJ9atHm1GQtDGHC3DrAXu6sv98tCumDL35KcdAxeZxvxJ6hK4RalRfQl5Xry2EK
         Hyo1uuXmxMD4Gfo5G3Enr0IBkt9Jx+uVOgSukWNdSEc7bhm0pF1Fi5m1vAfx4J7q5svL
         uPh9hD43gvKbvkNSnn31AZko2CLp448PRIC/Pz0NVMOUZe7xWmYaO91yz8ddgLq1cQyL
         7JRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762757794; x=1763362594;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1WY1CcuShlRk2we91Kyt0bCpaTxBq3s2lFYDIeGQFjc=;
        b=W2AyjOj+LjwrvSSnngcqBxzGj24WzezESmhJ4Lf+09bzM7sOB262GUL7bmDixwfshk
         +/b5ChJ75oiR/mMReBFjpGsvDtwjn+rlVU2dCedwS/uZsxrRhx1L/qs7VDV6ZZQSrLiv
         KQdrgfrB5LRyKIytLzVcFD7ThPaJ+Hwy76oS0Zf3rdJl/ILX5dEyteajuZRhuLJ0OOc0
         xYdyM2beKe9TNwKXRVTF9Ew3ufL6yZwjTl2ZOoyrdOZm+A6UETD6zsAq3FlttRIJS785
         PBxZFtVMYF0h4Wtr1iSVJyR1BTPSG1JN1hLr5nOgjuDt2mtKsvyFRubG0WYkBLObArS8
         CVjA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ7eZxCLJOW0dDCrz/+Ve/YYwsV0wCzdYJJZ0MwtrdmhLCtyAJm7CKe541BTbnxdJ1FiMPGfzRokKHyg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ7X1JNxMp/44GWMEKdLWlYH+//rDpOs0HYqpaTYvFG+hTpTTZ
	Rj+RUHSXZ8ySl3BPL5O8TscTZD898Ze3ijhxYBFxyUqJVKwklL0hSpem
X-Gm-Gg: ASbGnct8zzgKjIQICbLjgtD6bM88bGnbyrQ4VqJwkvi6F60n/xtKsWVgzGBj1P24NNe
	3ajxs9SCKglXRx3qS4PI8FUsQ8YodPrJ8KCkVPKs7scb9ma3Yxvikd0ozz5lUpsutQCCTJDD2gg
	ldviiTJk/huc/MzIHfxDRwGFBoyh5WuId+xJ57V/t3xVUjjOvgbAr+KCLbgRp6x6bDofkxDHc0U
	4yhKh29QXCJ9o9otKA5QOscTiXwTGYGcOQc+/WFtucsJruPvMEYzGE2e4v3asKbpblYh5vd1IbX
	50Uf5m59c9HAnO2udTfvj8bjtB5ON0HUlJ4+10z08WA1EV+HU1QFA0lFtCTEhvkGVX1Rcgt+Kg0
	UjLie9mj9GfbqE6qYSUjzaDgWCDD2OySZ9pnF1CEuxLShRlF7WGT4JL+pRvuw5vLzCSEDhMtJaW
	PlY26GbjQObaTpz0O9ZetF81OXZ+rdDX3hQfdAsYQ1c7OKCGR2RfyK2kR1TA==
X-Google-Smtp-Source: AGHT+IHO/HHwLn1ypxfIScvlrVfWexbtPhQMjjTTwSmPh9HSJNcv+2vgzbGH5WKsvvttQQePqFv3dw==
X-Received: by 2002:a17:90b:1d90:b0:340:9d78:59 with SMTP id 98e67ed59e1d1-343535f6b33mr12883342a91.3.1762757793661;
        Sun, 09 Nov 2025 22:56:33 -0800 (PST)
Received: from ?IPv6:2401:4900:92ea:6c8b:9820:381d:1e5e:1579? ([2401:4900:92ea:6c8b:9820:381d:1e5e:1579])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8f9ce9645sm11854081a12.10.2025.11.09.22.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 22:56:33 -0800 (PST)
Message-ID: <726395fa54b40f117edc0a72285d28a70c156912.camel@gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v3] net: ethernet: fix uninitialized
 pointers with free attribute
From: ally heev <allyheev@gmail.com>
To: Simon Horman <horms@kernel.org>, Alexander Lobakin
	 <aleksander.lobakin@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel	
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang	 <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui	 <decui@microsoft.com>, Aleksandr
 Loktionov <aleksandr.loktionov@intel.com>, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, Dan Carpenter	
 <dan.carpenter@linaro.org>
Date: Mon, 10 Nov 2025 12:26:24 +0530
In-Reply-To: <aQ9xp9pchMwml30P@horms.kernel.org>
References: 
	<20251106-aheev-uninitialized-free-attr-net-ethernet-v3-1-ef2220f4f476@gmail.com>
	 <575bfdb1-8fc4-4147-8af7-33c40e619b66@intel.com>
	 <aQ9xp9pchMwml30P@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-11-08 at 16:36 +0000, Simon Horman wrote:
[..]
> > Please don't do it that way. It's not C++ with RAII and
> > declare-where-you-use.
> > Just leave the variable declarations where they are, but initialize the=
m
> > with `=3D NULL`.
> >=20
> > Variable declarations must be in one block and sorted from the longest
> > to the shortest.
> >=20
> > But most important, I'm not even sure how you could trigger an
> > "undefined behaviour" here. Both here and below the variable tagged wit=
h
> > `__free` is initialized right after the declaration block, before any
> > return. So how to trigger an UB here?
>=20
> FWIIW, I'd prefer if we sidestepped this discussion entirely
> by not using __free [1] in this driver.
>=20
> It seems to me that for both functions updated by this
> patch that can easily be achieved using an idiomatic
> goto label to free on error.
>=20
> [1] https://docs.kernel.org/process/maintainer-netdev.html#using-device-m=
anaged-and-cleanup-h-constructs
>=20
> ...

Understood. I will come-up with a new patch series for removing these
two instances

Regards,
Ally

