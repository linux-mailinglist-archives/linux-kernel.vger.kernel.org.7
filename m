Return-Path: <linux-kernel+bounces-750842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C18B161AD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C2E53AE3A3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FAA2D6407;
	Wed, 30 Jul 2025 13:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYvRGx1H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C01F29E0F8;
	Wed, 30 Jul 2025 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753882798; cv=none; b=GSAVtROC5fE/LI07O2jkc92NgdGHJ9/SfRucKtHA1dE9fdo9jUZ/C4GINJS1D/F8oINFFL6RUNrb9JrUdnpllSJCYabzXve/ULvwpnRmQpcpTvDfv8Vbz4IQkayRavW9dMbyHDEFzD9KWoWaMKBxkLa293HknWSrD3hN06Dwo1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753882798; c=relaxed/simple;
	bh=FvpLspMfizkDeBxIkg/xekgU7Uyfj0y7AN+Zs4GVRs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kwy1M/XCsMGXr6b1Alz79xzSipLb0IDLvu6pUITLa5lsTMmp5KibnHXo0930VzlveW2+G0MwjnhV65qCBZK0TCotnY70rRgObyEyiX1y5Go47zgFYCLQc2lLIYdlCs+JyuPCtAcVntkXs6vrxNKWvN/8/UxtwgcIy1GuCdzsSp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYvRGx1H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB4AC4CEFA;
	Wed, 30 Jul 2025 13:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753882797;
	bh=FvpLspMfizkDeBxIkg/xekgU7Uyfj0y7AN+Zs4GVRs0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UYvRGx1HOii8U2PLosDu5LSfDQtE9dwk+Aet8Pe1cQHnOVjMRGtlwwyZ53J2OmU1F
	 qA9BM+treVzWycMpomTkJrWFSYbNfwzMlOt2Zr40zlawQzOL5zt0K3q7qt55+CXfHi
	 OQahU+HDeqNVc1RS59Vk5p2cuvsLqj6277aeCrWUseUMcCYMMdlB78+fqnIbbRUKX8
	 njaQ7NYU5vwvwUlV9GChZkN2sHg0Gn6mdW5b0G5seUusE7fL2BpKDCEYF7Ycm1Qsrc
	 1Jp8oH6WEshdbhc4DIcwirth+9r5N9gIDRVxRfWgM5dopld/WDffT6dGaXnwyH88kk
	 bBCZ6TgHsGOxQ==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae360b6249fso1240737166b.1;
        Wed, 30 Jul 2025 06:39:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWp1Xf01L/yHqOFpJtMXYuNj17sssAkNKbZGSZ43JcrdkUhMGhPKFIY2JTbPlaO+vPKpGmrgRfmTw1S@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtjw1o0gFxEu78qIMXzdWJZIGQ0Dt94wb103zbpIa2k5JP42IQ
	nyX1ZHAWGb0ktvStuxtzBd81tF86BUvmbXULnqltUxDY9ud3aUiWhJ59aAassf9lwyTJjNUxDVY
	x4eiMdF+hm/H61VzYdVUWb3+934whaw==
X-Google-Smtp-Source: AGHT+IGPoa94KZMO3CxT5BHxcNLbFX0ka6sBY/j36WnCxd4454EPYg+eCD7JAlMEsyTiIf2ckWZOq3V0iWduPco48Ro=
X-Received: by 2002:a17:907:9410:b0:af8:f58f:89dc with SMTP id
 a640c23a62f3a-af8fd9ed6afmr432683766b.41.1753882796266; Wed, 30 Jul 2025
 06:39:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753865268.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1753865268.git.viresh.kumar@linaro.org>
From: Rob Herring <robh@kernel.org>
Date: Wed, 30 Jul 2025 08:39:44 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJn2XtvWaDBSqYPUe2ZVxE7t4EbAt8OPncbQaKjh1jY5w@mail.gmail.com>
X-Gm-Features: Ac12FXxEywWNtZl5abfalLDGdegqDfPIjD9L5lbHvRJWQgO4YCOCdgR-mgr7rc8
Message-ID: <CAL_JsqJn2XtvWaDBSqYPUe2ZVxE7t4EbAt8OPncbQaKjh1jY5w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] virtio: Add support for Virtio message transport
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Saravana Kannan <saravanak@google.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Arnd Bergmann <arnd@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Bill Mills <bill.mills@linaro.org>, devicetree@vger.kernel.org, 
	virtualization@lists.linux.dev, Sudeep Holla <sudeep.holla@arm.com>, 
	Bertrand Marquis <bertrand.marquis@arm.com>, "Edgar E . Iglesias" <edgar.iglesias@amd.com>, 
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 4:29=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> Hello,
>
> This RFC series introduces support for a new Virtio transport type:
> "virtio-msg", as proposed in [1]. Unlike existing transport types like
> virtio-mmio or virtio-pci, which rely on memory-mapped registers, virtio-=
msg
> implements transport operations via structured messages. Those messages c=
an be
> transported through different mechanisms such as mailboxes, shared memory=
 based
> FIFO or specific protocols such as FF-A on Arm.
>
> This series includes:
> - Core virtio-msg transport support.
> - Two message transport bus implementations:
>   - virtio-msg-ffa: based on ARM's Firmware Framework for Arm (FF-A).
>   - virtio-msg-loopback: a loopback device for testing and validation.
>
> The code is available here for reference: [2] and virtio-msg loopback and=
 FF-A
> test setups are explained here: [3] and [4].
>
> This series is based on v6.16 and depends on commit [5].
>
>
> ### Memory Mapping and Reserved Memory Usage
>
> The first two patches enhance the reserved-memory subsystem to support at=
taching
> struct device`s that do not originate from DT nodes =E2=80=94 essential f=
or virtual or
> dynamically discovered devices like the FF-A or loopback buses.

We support creating devices from reserved-memory nodes. Just add a
compatible which you should do anyways because node names are not
supposed to be that specific or an ABI.

Rob

