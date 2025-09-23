Return-Path: <linux-kernel+bounces-828544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF01B94D8D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C55174FCC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B16C316194;
	Tue, 23 Sep 2025 07:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="veqKf+8t"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7057548EE;
	Tue, 23 Sep 2025 07:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758613613; cv=none; b=LAtqw4fpowXP2DgEKzrdOCEvWtU+9UQ77s4UelvVhHN5AWFi4mO9GUFyPREiM+eLVJq7DKVgsv80NB5jj3EjVcj8f/WVp7NZyOwPbQTDMyVHfuMnJXerWH6KqTNzeXmU4MCt/mDQphQIjciy+BUyQYo0orB6a6CynycWncELg0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758613613; c=relaxed/simple;
	bh=sLEA1vbZ7ZIojw8CMJsshRXsSZYu+1oNvZ4vhx+W61A=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=VJ/En0rfk/IIMXuI5HiIsGQ8b1xZahO+1jcI49YJbdSmPofpFR/DQqUDCMKBAQ4EUNkmeqOn0qXHA/MZZwdxe9r0+v4LJMGhP8ZkLTvVkp0VQseQC6RzWG3W6UDslOtG7ETsutU+QXuI1y53ZYbRXJyzt6GJQmuvMUewHC/Y9DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=veqKf+8t; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1758613603; x=1759218403; i=markus.elfring@web.de;
	bh=71XMaPe/C82i10yb9dqzYq1c41075rNujlLDfGeakzY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=veqKf+8tSMqAJF2c+751elPs++9S9JDMPIWG3Wx0YjI3EEg23kEcJOWg3E8e/zOu
	 AvsYfMiNrPiNYQ/FdUcPkSIJmQH2m1u7f6DW2b3oLYAYBbNI4uHct7rUY2zrlwNVV
	 4AoScyKCiZksX21/9KHwY6HeORYw98g2YNDH/830akZfzfFRKSjTTdRoutI513G8K
	 mqCKjW/7Y9sJZu4hKXtgx7fS6QtTk/eI8gmyCZeefhJDVhMz9NX4rCZMY6GdgzDfm
	 D0YegJ1Wlv/lLXaQlUOzN2DgZtPTw/0SNo2cWZixbp9wkf3EYVvKSqGy2cJtQLYDG
	 49sS/8I9XtsNkdouwg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.248]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MkVwi-1udV8v0lOY-00gLG9; Tue, 23
 Sep 2025 09:46:43 +0200
Message-ID: <520bab83-191e-4907-8d47-3d9ef8c7c269@web.de>
Date: Tue, 23 Sep 2025 09:46:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>
References: <20250923072520.3964688-1-kaushlendra.kumar@intel.com>
Subject: Re: [PATCH] arch_topology: Fix incorrect error check in
 topology_parse_cpu_capacity()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250923072520.3964688-1-kaushlendra.kumar@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u3Nd28TcVNWSbzLqb+c+EN6Yb5bad4rsJlc6bp+s9MtcbEOfddL
 Jjh/P6GMuxVf8w7tlepYIQYzRaMQi5A50Ee82IT6y/7hXDhLuvDilgUSA20TqGrQLRbhhF+
 DKFgYINmv2gBcjFQpVHMZSVRLLlSAbrWHXbiMK6/YlPV2hIOD6/uIClKSmOwvwnIWT2W5b8
 5RJ7ATcS0Vf81G0h45Jkg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KpeJCPpBExE=;JtmDx0Ne91ZcSurTsnD4xXnQJq4
 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
 LUZ2tn4=

=E2=80=A6
> returns NULL. Replace with IS_ERR_OR_NULL() which correctly identifies
> only valid pointers, ensuring clk_get_rate() is called only with valid
> clock objects.

* Can the change description be refined based on documented macro call pro=
perties?
  https://elixir.bootlin.com/linux/v6.17-rc7/source/include/linux/err.h#L1=
01-L123

* How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and=
 =E2=80=9CCc=E2=80=9D) accordingly?


Regards,
Markus

