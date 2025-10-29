Return-Path: <linux-kernel+bounces-876448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB72C1BB3D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27797587A8D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F82B2DF14C;
	Wed, 29 Oct 2025 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrROuBN+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856A45478D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749581; cv=none; b=ryIWPBv8cx5DFXP3zQvTnloKlJ64rg0WeI9OT0fbGjYtPCnkcCFZ3BJUXPHcV/ElH4SpiBUzfZ5PUua8GqmhY521M81QNcN5SppR1GL2ccmbzH4DpPU5HtoDTXttIBW2+rPzLBmZ88ivtbLYMX5ywhbyGQ0q5lyJmED14lqpAzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749581; c=relaxed/simple;
	bh=DQH0u0ZQDLwDsRJfD+har9LQ+I2HvcKD308oH6IRn4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0hwCB9t4lKZosE4SZSqJQy8UGabfL2e0e6JYwcunIA3EkMMXlQ7/1YGhazSFvFhcysN+WX5T3SXkkdzBT597ikzKt+h6dVz4ODgnxux6jow8RrpWcQD6akXy/bJg196kuoqXDjp1ydvlGWoTNxTLhJFZZsyXYrbMR1dsIyRNFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrROuBN+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F023C116D0
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761749581;
	bh=DQH0u0ZQDLwDsRJfD+har9LQ+I2HvcKD308oH6IRn4g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YrROuBN+4pUzprXbDRNtrGilh5vjmxWMpum30kAPxchqj3hBTjq0jgOmqIigwjEv7
	 sleoF+ejftj19YPlHymSo2FZNnDUZ+978ZMRbNbeNkdkuY8Ea/81fpU8n+HOs4AWSB
	 cWxhPmQum761vdie//HW3LueIVjEIfW8Y5l/XzGT9OQEUXNQruLkU7BRU2OXYyfClj
	 NRiU3+JfoLi9DnEpJaOvGM45wDANGAbKqQ06rVHYB4rFlAhOyVjBFFvAhKpQYicaIE
	 +5NshrDY3FA3lkaet+ghjBdRUFQ2Zf8cVunm1IwU6zrL3wkNMi2RbBFwJQ5kwuAfIa
	 S41ANLOKl3LyQ==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-3d1e68f7a6cso456fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:53:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWfdm8beZ7pPkw+TAptC6rP1bbgU2nC98U45UVEHLGkWxyV5LAhtmU+7VZz2A+CBWF/pzFPj98hzE1kGTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg0CgpHVdBzdefY6t7I697a3d2kavE4q9iB9iMmo0q/g6yCSXQ
	UuTsogcCsNEW9gukXuinBIcoY7jD0QBcnZDWPdYh9GmrURD/uBTz5bnpOOU2XFkrGN8U/zXR5AI
	HFOPQkJYDklWMeaua3HUHx0Y4u5VPCSU=
X-Google-Smtp-Source: AGHT+IHHEvoo8S5ZVkziH9usRZKCB4chGD4vG8XKVdFlee3Wg2AG1vFPXwy4+TktAqvO+ZdeeRHTEvLsRUtwvAjhYoQ=
X-Received: by 2002:a05:6870:a08b:b0:2e4:68ee:4f21 with SMTP id
 586e51a60fabf-3d745b88130mr1293044fac.20.1761749580304; Wed, 29 Oct 2025
 07:53:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016151929.75863-1-ulf.hansson@linaro.org>
In-Reply-To: <20251016151929.75863-1-ulf.hansson@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 29 Oct 2025 15:52:48 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i_0K6+nCvBC55Bbu7XuKYjHrky3uG_aZ3aM0HMymcfeg@mail.gmail.com>
X-Gm-Features: AWmQ_bmuSJXu6C45Iw4pt8DNu7Ct3CGGKWF6PwDtKyiHtfXjuVhrJ-viSshACfM
Message-ID: <CAJZ5v0i_0K6+nCvBC55Bbu7XuKYjHrky3uG_aZ3aM0HMymcfeg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] PM: QoS: Introduce a CPU system-wakeup QoS limit
 for s2idle
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Kevin Hilman <khilman@baylibre.com>, Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 5:19=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> Changes in v2:
>         - Limit the new QoS to CPUs  and make some corresponding renaming=
 of the
>         functions along with name of the device node for user space.
>         - Make sure we deal with the failure/error path correctly when th=
ere are
>         no state available for s2idle.
>         - Add documentation.
>
> Some platforms supports multiple low-power states for CPUs that can be us=
ed
> when entering system-wide suspend and s2idle in particular. Currently we =
are
> always selecting the deepest possible state for the CPUs, which can break=
 the
> system-wakeup latency constraint that may be required for some use-cases.
>
> Therefore, this series suggests to introduce a new interface for user-spa=
ce,
> allowing us to specify the CPU system-wakeup QoS limit. The QoS limit is =
then
> taken into account when selecting a suitable low-power state for s2idle.

Last time we discussed this I said I would like the new limit to be
taken into account by regular "runtime" cpuidle because the "s2idle"
limit should not be less that the "runtime" limit (or at least it
would be illogical if that happened).

It looks like that could be implemented by making
cpuidle_governor_latency_req() take cpu_wakeup_latency_qos_limit()
into account, couldn't it?

