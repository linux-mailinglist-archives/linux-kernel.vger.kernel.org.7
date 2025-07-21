Return-Path: <linux-kernel+bounces-739508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68471B0C71F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3159616560D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BE52DFA21;
	Mon, 21 Jul 2025 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="h9pwDSDY"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E3D1F2B88;
	Mon, 21 Jul 2025 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753110014; cv=none; b=kEp9hIyYIrC50TLPk2f9vti3WlANJc/4D+r7f8dyXuM+Z1SErZ3PNdVBXqqVbZ2gknWrCt+G2cwlXSEvXwx+wAJUsGtKHaHv2xaLfIgDT55RfakfVsdIPb64BDSPk8kStX8F1yZRU1of0AftHYBXVmq/18Ltf+aMB31zJdkfkUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753110014; c=relaxed/simple;
	bh=YdGdIUzGDCTtvrJYFfci2x3wZd1A2omkVKORRi2URfo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=KbpFWAQCmYwSqVWRfqGrnkgSOFbQPzn5b91KvJhEteBA1e2vg6AGixjQmxgF/ygKKvSuZ+ztVXhufqiDbLVZxg6RoO1xQziLHpGpgRY9w/li/mu+g3QdmHfaoATPXOI9ayeTfjWpylz1b191IPA7C5U3lFkzK7xKOkSnsFUuyr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=h9pwDSDY; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753110009; x=1753714809; i=markus.elfring@web.de;
	bh=YdGdIUzGDCTtvrJYFfci2x3wZd1A2omkVKORRi2URfo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=h9pwDSDYV+x0j1BVROxKD1jHZDUASe7fTJaBz9KnobowAznmty+9Y6vNQIGX4An5
	 AwYd63ShCa0V+f6ZoeEy4zPOcpnH3t29hX9zTqV4hafNqG6bPwjCZIW/DUnPId1eZ
	 wRY8G3l5O19Ib91rAjUD7TLSjNFFWq8um7DqfWzkxcB2pbyvoUZzHvbzLsFr5ne48
	 h+LKgZj9qpsDSygWIIzB7gtAcD52zpSDYHriPk8i00W2x0C2/dKTkKViR0ioBG1qz
	 k59pL1CxEg7tr4BsYfXJd8iOX3FClScvNGsRSCg6fFUTBlT2FaHwqm4z03CwzDRHM
	 3wHc9qZU/meTOZtLUg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.235]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MbTGt-1vBHs00yu9-00m6QU; Mon, 21
 Jul 2025 17:00:09 +0200
Message-ID: <21c3aec1-0284-471f-b336-cdcc832ac6fe@web.de>
Date: Mon, 21 Jul 2025 17:00:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Erick Karanja <karanja99erick@gmail.com>, linux-sound@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
References: <20250721114554.1666104-1-karanja99erick@gmail.com>
Subject: Re: [PATCH v4] ALSA: usb-audio: qcom: Adjust mutex unlock order
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250721114554.1666104-1-karanja99erick@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:w+mFUtlnRuvfgXl9YixeL17l4EWoMKVBnw9ievHj3I5pCWvCZZW
 nZ8Qc+Kk1B+592hsIvlMUVFntpHnuslRxlY1Mh9jVYnuh+jgLUyfi9Fw6Luvwb2peeeB1iP
 YhNdZeEPA4NQZX7wR2v0bNPMdBK6c+PJq7h4atdb5l1KkOkPFOEAAl3br4TYp5MdH/k3FwU
 WHi8qhnFA3e/LD4SBit6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jW4RJe+ueNc=;coiFDbCR2ppCGT5FhPjOlRIH7i0
 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

> The mutexes qdev_mutex and chip->mutex are acquired in that order
> throughout the driver. To preserve proper lock hierarchy and avoid
> potential deadlocks, they must be released in the reverse
> order of acquisition.

Would you become interested to benefit any more from lock guards?
https://elixir.bootlin.com/linux/v6.16-rc6/source/include/linux/mutex.h#L225

Regards,
Markus

