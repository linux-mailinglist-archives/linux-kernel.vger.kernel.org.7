Return-Path: <linux-kernel+bounces-784776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B2AB340E0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0825F3B3068
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0592274B22;
	Mon, 25 Aug 2025 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="sgBDxhaS"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9497276057;
	Mon, 25 Aug 2025 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129025; cv=none; b=KQJDX0i9JQRSXGUzlBCTbSecLIQWRnH6kp2mHEv8fjUQQpJWYh7VooApjuI910p9zJvta02GvZZf1k1r6ZXaYms3IL5/gvmY/UOAqmJNnJEX0q4JWc35H2t3HtR9aC9AOBw76ayuqw3UAJH93ui3tjsKrTCBWMa4hQ4y8wi+TsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129025; c=relaxed/simple;
	bh=itp++X7BYMDX5+/+FeQOCqCW0R/HDrEBOWoU0zLtfvs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=AcZBuv1lINFk0KB+dI+Z0nJIGEFx1+apcNI4sEKE65ylsfgd2ZfCJjCEG2Cdi3vnmLEg93Ir6OdtcTfao9p7NqFggalcyUsPW9F333MLyBLDZlQaqwWtVUgux3b7Dgwy09544zEuDAlQnob/+JuQvQjRYHBjeYKBcOQbPGf2Dp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=sgBDxhaS; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756129011; x=1756733811; i=markus.elfring@web.de;
	bh=itp++X7BYMDX5+/+FeQOCqCW0R/HDrEBOWoU0zLtfvs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sgBDxhaSBQhJJ60HZuPUJOBYxWYfVdIWuBLxzlQkS8XId8xb0ZqI8UaEUTTd27v/
	 IpmFka1PQm1FL047YQE+qjsMekgP6sMCuCE5IlA22OsEPHTZPvpoXJ1ILUt9v4v0a
	 yW6xwbkMdgnnCaRDLGsYkKpKhXPwaS2Uvpeb+3v1YixdJFdzruPLFgOilhscxAGKG
	 MjYb6QnbhlS1H/T8CR6VgVXQ+KzozZGKXBCsEsMmxQUoYEWRb5b+cx6IBOVUNEx3n
	 InSbNCGYgpqu0e2tMVKD6iGBSHPIZrmbJ1P9Cpq/JzhGntngxRC2UHALXujKe+1YR
	 nQ3ZGTxZoTBwtL6CQA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.250]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTvw0-1uzmUL1rda-00QYCL; Mon, 25
 Aug 2025 15:36:51 +0200
Message-ID: <813948c1-e534-49f8-951a-0b81ae543c7b@web.de>
Date: Mon, 25 Aug 2025 15:36:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Mark Pearson <mpearson-lenovo@squebb.ca>,
 platform-driver-x86@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Kean Ren <kean0048@gmail.com>
References: <20250822152549.4077684-1-mpearson-lenovo@squebb.ca>
Subject: Re: [PATCH v2 1/3] platform/x86: think-lmi: Add certificate GUID
 structure
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250822152549.4077684-1-mpearson-lenovo@squebb.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ewe6oaSWGQekhZdjDZ5VBP9HKh6HSeNS6Y0s/MvEU3x0is1Ff+5
 4J0aeLEOYbQgnA7kBPWQ7O5y+39SXEfUVMaAwl8/mqJHriw0jaXWrI3mHQWbo3JIG7R6jeD
 tYGJRbcSWwNiwiW7vf7JAEpKCByZZDGs986TRBENkAyu3gqn4IrYVmkWtwfncPh2D4qJEoQ
 DxAZsaHcfuGjlazf5WuVA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EeNlRPJ1woE=;WoQLqCjBATKPUjUlsJSuamwiSUc
 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
 mvoRbgBNPZ9o+YIDM64tGP0HJSCS

> Add a certificate GUID structure to make it easier to add different
> options for other platforms that need different GUIDs.

Would a cover letter become helpful for such a patch series?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.17-rc3#n310

Regards,
Markus

