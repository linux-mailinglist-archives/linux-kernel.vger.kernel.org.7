Return-Path: <linux-kernel+bounces-875370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6FBC18CCD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2FEF1AA66C2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B022A23372C;
	Wed, 29 Oct 2025 07:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="wsZ7Vpkx"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118F02F60A1
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761724421; cv=none; b=l9YvY9PNq/oaUjbTHVwN05Md22qK9uWlgXjxzjbxBV64CdwSMGFHqrHBl+i4MP4IaqtArUp/8T1IFSpuu1ZAojU87O9iZuHGqxAiHtNgO+TPl1SkXFxEPZ+x8qjfnz63dvRQl/VMJcEYW8XGu+OXpP1NDF5I0mT9ObOL7ITzu0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761724421; c=relaxed/simple;
	bh=53CR8Bh5SPr98P275zta4br60j/YwcTjhCc6c36UQgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hXVG0tlnbB4Nuix/0IEcY+lM0v/lU0Tqv3v/ln1JcsUrOPTGnmLK7bguvTheBnmylh3XAf0JK1gkWzBgMW5damX0OYllzxBUua3fUYMj2T9fD2BBk/8trXnyXw00wzWKHl2nWeo6Aj1w641uSaP+HPRfJAl/2UqFFOztAIqIlJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=wsZ7Vpkx; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761724405; x=1762329205; i=markus.elfring@web.de;
	bh=53CR8Bh5SPr98P275zta4br60j/YwcTjhCc6c36UQgg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=wsZ7VpkxiFw/ag+23peTmb15DAfgPLJZM8k3irzUStkK1RiMghJt07fRco5Ck5Ac
	 c2UpXQhHFiAitt9aSmA6e+nSvuqxsatOcN7p9gLZwgrFn/lBC7xupfT2muZ44KGIT
	 EU2eEQqia9FXtClpJyEVfqQ3GRYDRbfmKu+58cwQowGvusOipBFfLVhy31TpeiCUi
	 zEs4p9uRqmdnj+5gPtaPK0ZzNaK310lVNHdKf2MYUespHP2LWDHFU18UivZBvLUJ9
	 jVK6zpj57t6VAu494zjBnyG9XYHY9M634VqZ8cr/xpnzV6kPXhk9+tBcnLqtExhV5
	 29or2uv1tJqTAb1A1g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.249]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLzn1-1vVGjM2nIn-00S0Ci; Wed, 29
 Oct 2025 08:53:25 +0100
Message-ID: <6238912a-8733-4b2c-a155-82bb081e6063@web.de>
Date: Wed, 29 Oct 2025 08:53:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: accel/amdxdna: Fix incorrect command state for timed out job
To: Lizhi Hou <lizhi.hou@amd.com>, dri-devel@lists.freedesktop.org,
 Jeffrey Hugo <quic_jhugo@quicinc.com>,
 Maciej Falkowski <maciej.falkowski@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>, Max Zhen <max.zhen@amd.com>,
 Sonal Santan <sonal.santan@amd.com>
References: <20251028175452.2329497-1-lizhi.hou@amd.com>
 <b7a2ac2a-53c3-49ce-862d-eaba86f0b298@web.de>
 <605e6f4f-8e96-dbe4-d43d-16bcac63f94e@amd.com>
 <3dd7e061-8e6f-4d3d-b56c-7005da8197f6@web.de>
 <b2cf67a4-6795-d743-e90b-db10f636db2e@amd.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <b2cf67a4-6795-d743-e90b-db10f636db2e@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WUBRdfcOWMblhe1gb6zPcBCg5r3KZFPkHjliYl8GNqkbgRk4ID0
 o3fE/JC5S9hZQ6W+0uMfeLcG1HcVb0wiB2aGI66EOJWenANDN1JmeWIoF8DLaEt9vkPceH5
 ledHZoIE9Ym/DU9/OuwMNn0y/eCKAQw/SkMzZL/9w4gF9vwQUTIq1RPu+JnDv/bqA0PcWyq
 IxQdED4MMWDyRMJSPWfWQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HKDcG+/LqDM=;TVYFHu9fTSHJCzdA1dtSzVkud5a
 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

> What=C2=A0are=C2=A0the=C2=A0duplicate=C2=A0statements?
>=20
> Sorry=C2=A0that=C2=A0I=C2=A0am=C2=A0still=C2=A0a=C2=A0little=C2=A0confus=
ed.
>=20
>=20
> The code change is to distinguish between the job which is=C2=A0 timed o=
ut and=C2=A0the=C2=A0job=C2=A0is=C2=A0aborted.

Would you like to clarify the usage incidence for amdxdna_cmd_set_state() =
calls
in combination with assignments to the variable =E2=80=9Cret=E2=80=9D (acc=
ording to the implementation
of the affected function =E2=80=9Caie2_sched_resp_handler=E2=80=9D)?
https://elixir.bootlin.com/linux/v6.18-rc3/C/ident/amdxdna_cmd_set_state

Regards,
Markus

