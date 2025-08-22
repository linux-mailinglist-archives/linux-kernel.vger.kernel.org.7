Return-Path: <linux-kernel+bounces-781789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2752FB316CC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 959C9AE465B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEA12FA0F1;
	Fri, 22 Aug 2025 12:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="TYq2FsLB"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993FA2D7DF5;
	Fri, 22 Aug 2025 12:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864039; cv=none; b=QX1CIVD8CW39J7aPY9+1g6KLVAvvHt8ZdQI0MdFRXp+loTXZzB8hF1QHG4OoEi9UP3oyIsvOgPMPLcICj5tm2ax7o4yr4j+Y+rF5x04C4UsK2SxIeVrIipFYh4aashkYgoWCz7pR+PZzgBwiOjAIZVfBhsMJVZYrXZl6xo4Aabk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864039; c=relaxed/simple;
	bh=j/PHFwFQyeZC5x+M4hZ/FInqHN/UmN4edBE1iMIfpB8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=iF4ktmpP4CZteEMEBwuicGKdAng9ybtf+rcFgt41LsLrdhbxyo9oPF+4T8Zb3QmdOCE63sbq1I5sldI66HXCtWwOJ9u0aRypofRMN53NjXRJuflHVXxFkn+OXpCwhUMg6JesBEdBry0U9z4JEkE1XJh8Vfa8RGq/7Ctk44Z++3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=TYq2FsLB; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1755864023; x=1756468823; i=markus.elfring@web.de;
	bh=m4BknXcAVSKp17JscyULcRyQ1UHjIYAVSX3FSV7X0Ko=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TYq2FsLB4U86mbf4I+HmWNtdGY7eWd8EKKP2NldsQDiVAvev3ywrlQfUqxllJI7c
	 /GCg36iicE/2GMZYS5a5wv0LwRPB6c7Ot6twPs91+1ej/KY3AVVTmIPrU/lBv1cu6
	 gE0iXIwBZvmaOK8Cgp2cGWAC+6SW6rpBC4SBsDTshFXvpS/Q9G6XoDJeFaxNI+m0x
	 G18SS2gk3Sd+s3cipgO4PLkbdTbBxopR32VRSKkEyZ7ARzd9gO1bksh1fTQCJ6f+p
	 ZimN0ld4ukNbjLGBp7vWnMoDFaNgy4FMfZzospXlp4gE7MqUJcnGc5zgUk7XwR1Zd
	 QeyQvyo/L+zfU7WDxA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.186]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N62yY-1uRItD3E3U-016lSn; Fri, 22
 Aug 2025 14:00:23 +0200
Message-ID: <c97b2c44-d03c-40d0-b2a8-e8070320499d@web.de>
Date: Fri, 22 Aug 2025 14:00:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Takashi Iwai <tiwai@suse.de>, =?UTF-8?Q?=C5=A0erif_Rami?=
 <ramiserifpersia@gmail.com>, linux-sound@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.com>, LKML <linux-kernel@vger.kernel.org>,
 Jaroslav Kysela <perex@perex.cz>
References: <87v7mtyrcy.wl-tiwai@suse.de>
Subject: Re: [PATCH 1/7] ALSA: usb-audio: Add initial driver for TASCAM
 US-144MKII
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <87v7mtyrcy.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:13ZwNEUV283A707QLweo6J82j8VrTu4VvtucraZjcQgBlnERs9S
 7TykcEbuyHJzfLz5xYafuSK6YYk6YpfEf4kk+2J+JnM2mBIwJvcd+/J8RTLZPa7X+qxLMLj
 ssdvTTC8GZKqJGyefjjSNW4uMlZwyPS9CtWRr8p8RJcuwdH0zSm6pJSZMSKts7EsR/fD1Fr
 q3KK7Mxevj2AiX+zo0ndA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NsAXwB+qMSY=;i7NQqALQnUYjxkqqijdx5gwCBuz
 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

=E2=80=A6
> > +	char *handshake_buf __free(kfree);
>=20
> For the __free(kfree), you'd always need to initialize the variable to
> NULL, i.e.
=E2=80=A6

Can another software design option become more attractive?
May the scope be reduced for such a variable (in the implementation of the=
 function =E2=80=9Ctascam_probe=E2=80=9D)?

Regards,
Markus

