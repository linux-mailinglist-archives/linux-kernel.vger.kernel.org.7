Return-Path: <linux-kernel+bounces-792642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBC8B3C722
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 03:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 075653B5C24
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 01:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB3E2206AC;
	Sat, 30 Aug 2025 01:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b="qQbM5YKI"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D172566;
	Sat, 30 Aug 2025 01:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756517911; cv=none; b=eTmCDda5Zlq9d91Yr/v659Cg8BmpdoVoNQh1RdowPsHNZUBzkWTmi/0GQs5Xo6kZAWdgukX+Xjm8IW2x+yRroIvFb67f9weUOE0wRP+FR/RrCWhH3uu/lWIN0p8ExAoyJvH5cFUrQjIiYNtYTeH3+XCCxItEjWPsLwRd4sNYm/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756517911; c=relaxed/simple;
	bh=luY52hBLJ5Jy94qVJsUl8OpOboe4AUBDWwt47jDJ8jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oqT8ICi6AYx2cH9ADcg6CcsG8oAUNZgVMsLWhv0Cl8yYbDx1b4aJV9o4ym5QWO7rPcgFWd50qL4SZGhcFdXIXiMcjV1keKtVE582LsjppWmp/HVzJygCzpc+iKx+TivO/5Pq5tPUZZWwIy2CR2YAQoavNrN4xOlYwxSZ4QaTwLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b=qQbM5YKI; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1756517899; x=1757122699; i=s.l-h@gmx.de;
	bh=o6NfW4hIfaRVVgpsN5Z0Ad5ciSwayv7dVV5SIhTfAm0=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qQbM5YKI9fzmaDTUUPNTOBLGPnxH8ehi9K5ALvwOrzywg1tlEkGpzHs2tVY4KKUA
	 iSSUi2n9slRoj2pcrs3bq6wwhUlR17UHf4uz7jdmPxbT1DHIzF6rD4Ady2ZZa3aBD
	 JUIeopCftTfneGYKGukdA5GXS0Pk0+go3pgE0AF9kMgUi/SzEDdDyYmtPyx4M4XCF
	 /cEcIbzQaF8dQ1zJGOozd9B47aTYD4YPZysNxFtYiEFxn/ipmtSbtzA+Ta2khmkrz
	 jv7AHzwcOjKJbjDe2dC1us1FP9tE7u6aV2lAYtlrCUcx+VEANbzWWZZYhnvK8cemm
	 uaF/p+iXE1oe/LyzAA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mir ([94.31.111.154]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQ5vW-1v5HaN0TFw-00PSKn; Sat, 30
 Aug 2025 03:38:19 +0200
Date: Sat, 30 Aug 2025 03:38:16 +0200
From: Stefan Lippers-Hollmann <s.l-h@gmx.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: "Luke D . Jones" <luke@ljones.dev>, Corentin Chary
 <corentin.chary@gmail.com>, Hans de Goede <hansg@kernel.org>, Ilpo
 =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Jiri Slaby
 <jirislaby@kernel.org>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: asus-wmi: Fix racy registrations
Message-ID: <20250830033816.1762169f@mir>
In-Reply-To: <20250827052441.23382-1-tiwai@suse.de>
References: <20250827052441.23382-1-tiwai@suse.de>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J/zvbESoo15ZWLH8lnjl2DejVq9Q0MLz/wNkemrezZW8KMukZd8
 mv6P6k6cACXPKW0Qj0DqxoLrSev1SIi2SVTA6yIbyFmCNH9ay1TmD9j2w7gYodpwPyTIMdX
 NF55NEt1Z0Fuul5sU6BrQomWQkI7GHOO8b+FRYDszQbHoKJmP5MlfQC8E5jPgJB822/gG6z
 Iwcz/qVuhNauE8e0M/d6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DdWE5jhfmXQ=;aZUhefkbEKm6wJ9/BFLH4mijJ3e
 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

Hi

On 2025-08-27, Takashi Iwai wrote:
> asus_wmi_register_driver() may be called from multiple drivers
> concurrently, which can lead to the racy list operations, eventually
> corrupting the memory and hitting Oops on some ASUS machines.
> Also, the error handling is missing, and it forgot to unregister ACPI
> lps0 dev ops in the error case.
[...]

Thank you very much for this patch, it fixes the v6.16.x regression for=20
me (my own git bisecting failed more than four times, due to false=20
negatives) :)

Confirmed to work on:
- ASUS PRIME B760M-A WIFI D4, i7-13700
- ASUS TUF GAMING B760M-PLUS WIFI D4, i5-12400

Regards
	Stefan Lippers-Hollmann

