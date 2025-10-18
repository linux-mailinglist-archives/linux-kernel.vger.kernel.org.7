Return-Path: <linux-kernel+bounces-859093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DE9BECC39
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 11:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F3C3623B20
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 09:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215D628369D;
	Sat, 18 Oct 2025 09:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVILu/O+"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA4A2253FF
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 09:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760779110; cv=none; b=rJy0srAzWDRUlJGub0sx83xwzt7klrhUwSMyFfisy10lJMuvJ/0eW+AdWuY9Ymjw/1ektIo3JSvG5/eqjAvhyW61fpWI4O/sz1k4S4rS1rq+HfN1Ns8wauvnf0T0/Sp+kSE05vLrLZ8lOMT53Z9OX+KoYt8afSWC9OMf/LN5KDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760779110; c=relaxed/simple;
	bh=jU5teLVUCnWZH2TochB0gAv9g9e8BPv4GBxUs8VxtTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+0bObfvvpUsvrwox8eKbbYpSWWBqdcuh/TvYkNLrqDuyN/qUvPVbcZwBX3ymozH6VM6hgMOeitdemPd6y6RyNBSnNczhFveOLDnv+BoN5cG0e6k8RZIJMsyRiNapSCbKJIlsgTw+azqtc5tsMYaEsVL3LcWAASLXepfQkJSVvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVILu/O+; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-57d8ff3944dso3231953e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 02:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760779106; x=1761383906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEx1UnLRAjNIB/wwt2DQvYTGt77QeDOtorXfzALGI74=;
        b=PVILu/O+FkgOyvp2qQaGz5Z5XQ4mayhhGnn7W6uTzL+fZxiL3/Ou7wcvt153kJmPKB
         Mdr9JpkYFXlwksae0RQIwJJHZQJJ6NcJs013snaSWD7V76FOYmO5E6ik+aYPjA3LeYZi
         tT5aLo+Zkwc9WsNaL54DPq8Ymmyb/AtSj8wAtRveNkRpq6gnKfI87+C/gPNHdAk9j72V
         nisPDWVAue3xxN8dW/vWWYbEEf+New0mO3SDrUfwgHhOMiPsVPklESNAKY7Mrd+N9jLR
         0a/iLuT6K+a51sQ+EYhtaoMuoYnL8asFJ3BdWDdQw8gSdTfnWYBlIdifRgDrIi+qwVVO
         iFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760779106; x=1761383906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uEx1UnLRAjNIB/wwt2DQvYTGt77QeDOtorXfzALGI74=;
        b=LGVwJkUeUBoYGtlck8IScPCSe+YQH5lyo60iVLPRB6oy7MHKkn9hRTo6hj9Y9LHrq0
         9bfc5vew6md5XYsgk+C/vnmnaSbcfS7tfWqY1upC/R79dsjaFNWRRuE6uYMeYCtgQdYR
         edqzvxQaF09AqDXXht4+JwGy3sMvI5K0TSDl/s6RlwDLJkZfsE6z0Y8l8j/rejujx1Hn
         0qkTGFWz4+HrlKD7g022mgfKck3J92aE9fqUCzLb+LBurkY72D6agiHTJWFurwXPXai6
         oHPSK77PUPxZQItzdbx1qXI5aM642Xp6NOwSeLoosJpA3yQGskYLQgUSzRmzN4jAD9rb
         tJDg==
X-Forwarded-Encrypted: i=1; AJvYcCUotXBmP1y/lAM4gOcU2/q/6uf4QaDx18AMYU/hsuNXX7+f7DxuWPZeI+WuUoapCxJwCUvIMDEgvzX1g68=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLiPnWn7Db/GPlwQ8yaoMilJGyc76WrhypRm2Xt0KPq4pc9ekB
	y62NGuvs0nw5vC7QnmEK5m5W0jY4A8mJTVtPNrS0vGWRO6O18a/brBhlk0PJAaAIJpB6pWgrRvP
	Pw5uAOWQqBdz3SuF6PHezdNFWRcg/9Fw=
X-Gm-Gg: ASbGnctpH5YyhcZKrQnEFvRIIG1h1D1f31nanaqeSwGkvR2SgPHnK8xM6WSLDh/HjHf
	0dfq6zjJFfC2DuZxIYszRzDVwaBiHIek3oJBT1jxT9Sps98b1D+PIsDdqUA4UYYfYO51eZWfn5J
	FXqo6UZRhJYPK2vS9KE4KpTOqYYp56QVeTA2DQHUniyMUF+iKxnHBzW+lQNGRF+iMfEkTrUtCy+
	hIDdsolKE6ITTiCRk7iicwxQq5/FxVzY8KHxBTUNpuAthGe59zaFZKR1bgAxcpZOIbf9zt6fSWv
	B0htW+LYvWfe2KMZq/it2Of1imw=
X-Google-Smtp-Source: AGHT+IF5rfW/tAzFpoM3n1DSLD8tOde3TxisLUADp6oDUAe+BnbdUVhgS+yCWVTV35rJ7f2Er0OCoRl2bK7p/uL8KBw=
X-Received: by 2002:a2e:bd86:0:b0:36b:f63:2785 with SMTP id
 38308e7fff4ca-37797a09b5emr19614861fa.27.1760779105708; Sat, 18 Oct 2025
 02:18:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017145201.780251198@linuxfoundation.org>
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Sat, 18 Oct 2025 14:48:12 +0530
X-Gm-Features: AS18NWDXwx6Nj-xhbGPfTIeoZlZlaSXTImQNfcEKqQrGDv7K4Hexvzb5wBkwwfA
Message-ID: <CAC-m1rqGHU4fn+VaqGfpuy6EAGAKbhoSfpy=6_PsSbUijATioQ@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/371] 6.17.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Greg

On Fri, Oct 17, 2025 at 9:10=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.4 release.
> There are 371 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 19 Oct 2025 14:50:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.4-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------

Build and boot tested 6.17.4-rc1 using qemu-x86_64. The kernel was
successfully built and booted in a virtualized environment without any
issues.

Build
kernel: 6.17.4-rc1
git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc=
.git
git commit: 396c6daa5f57fff4f0c5ab890c6bfe6ca31b3bba

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards
Dileep Malepu.

