Return-Path: <linux-kernel+bounces-809564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E11D8B50F1A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C97D173F8E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 07:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589E5308F0B;
	Wed, 10 Sep 2025 07:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grenoble-inp.org header.i=@grenoble-inp.org header.b="udLKDSEQ"
Received: from smtpout02-ext4.partage.renater.fr (smtpout02-ext4.partage.renater.fr [194.254.241.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408CE306494
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.254.241.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757488702; cv=none; b=LnzNXgaEGRZSW4eI+k3uRo9qO7hMzjHx/ITXdHu1jMbGsSqjhONWdsklZWIhbfcYEL8MO/R45PlSJScoLeoGq9qqdvioi3nKbDnIY1oXwbOSPJWrStMPbGs1fhbvV41CTW4Y3w2DDYH6zAocRjmFkylqXm1RBII2X+TskE5qk+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757488702; c=relaxed/simple;
	bh=vTyTqafs4PgWKg4ogYxiVmVIWLf9Jvd0sAOXaxaYu/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KLRyiwaSu4sHSdwGzFZHhS2NeX1IDBbEG30x9Lpi9N08wZ4KT952ocNJcNv00QHPbvQShDaE8rAyofHgKtxAPvxBRo9/evHLtgSNxbCDHu5TioeNVe1Y2OylAlFYDKIi7Y58VNXmzfm9DOvFq5jm2U/MKVczcoRMnHPweNdMyGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grenoble-inp.org; spf=none smtp.mailfrom=grenoble-inp.org; dkim=pass (2048-bit key) header.d=grenoble-inp.org header.i=@grenoble-inp.org header.b=udLKDSEQ; arc=none smtp.client-ip=194.254.241.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grenoble-inp.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=grenoble-inp.org
Received: from zmtaauth02.partage.renater.fr (zmtaauth02.partage.renater.fr [194.254.241.25])
	by smtpout20.partage.renater.fr (Postfix) with ESMTP id B836EBFE54;
	Wed, 10 Sep 2025 09:10:45 +0200 (CEST)
Received: from zmtaauth02.partage.renater.fr (localhost [127.0.0.1])
	by zmtaauth02.partage.renater.fr (Postfix) with ESMTPS id ACC92A0CAB;
	Wed, 10 Sep 2025 09:10:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zmtaauth02.partage.renater.fr (Postfix) with ESMTP id 993F8A0CBC;
	Wed, 10 Sep 2025 09:10:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zmtaauth02.partage.renater.fr 993F8A0CBC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grenoble-inp.org;
	s=F42A61D9-9621-4693-8E8E-830FB5F1ED6E; t=1757488245;
	bh=vTyTqafs4PgWKg4ogYxiVmVIWLf9Jvd0sAOXaxaYu/0=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=udLKDSEQphZYBqBCK3E0UrIXaQPGORDawCTr+KKPlBriSYOXpV9b/ECPqYsZK1Rwf
	 X0kDECQA6cTLJy2PQhFNRrTDW3unglpDiVEoFIJrSy4FGtmWLzC1vIvO8wZxHd2gRS
	 HBb0Xac1iI3n2R2Mb2cYLuCel0RPPQsZDzpQWpWz9+UkPTMLON9mmQa07x1tz3ZYmH
	 0mAmE4QPrOG1S+W++Jdqjs+SKPc7E7TOma7BFslfvQP8NmOptDtLSLIk4GLSJVeBy6
	 gFCwvxYCQwV/V7EjWrLXPosTpnWaCWNXqwFvbrFlg/BbCeNVlTSFIVMMsYPcOeju33
	 gIqcIeUu5Ng6Q==
Received: from zmtaauth02.partage.renater.fr ([127.0.0.1])
 by localhost (zmtaauth02.partage.renater.fr [127.0.0.1]) (amavis, port 10026)
 with ESMTP id kNv6SQ9vCpOy; Wed, 10 Sep 2025 09:10:45 +0200 (CEST)
Received: from 130.190.85.42 (unknown [194.254.241.250])
	by zmtaauth02.partage.renater.fr (Postfix) with ESMTPA id 58664A0CAB;
	Wed, 10 Sep 2025 09:10:45 +0200 (CEST)
Message-ID: <aff17665-36a5-42be-87d8-ca69ac167c8a@grenoble-inp.org>
Date: Wed, 10 Sep 2025 09:10:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vt: add support for smput/rmput escape codes
To: Jiri Slaby <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Calixte Pernot <c@lixte.email>
References: <5002d4f9-4999-4a84-9329-edb20098fd7a@gmail.com>
 <20250909202629.9386-2-calixte.pernot@grenoble-inp.org>
 <dbb5a124-4947-491e-8903-faa18e0e5bde@kernel.org>
Content-Language: en-US
From: Calixte Pernot <calixte.pernot@grenoble-inp.org>
Autocrypt: addr=calixte.pernot@grenoble-inp.org; keydata=
 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
In-Reply-To: <dbb5a124-4947-491e-8903-faa18e0e5bde@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Virus-Scanned: clamav-milter 0.103.12 at clamav01
X-Virus-Status: Clean
X-Renater-Ptge-SpamState: clean
X-Renater-Ptge-SpamScore: -100
X-Renater-Ptge-SpamCause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdeihecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucftgffptefvgfftnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepvegrlhhigihtvgcurfgvrhhnohhtuceotggrlhhigihtvgdrphgvrhhnohhtsehgrhgvnhhosghlvgdqihhnphdrohhrgheqnecuggftrfgrthhtvghrnhepgeekkeegffeuteduhfelteelteegveeuuedutdejteeuudeivdehheetveeguedvnecukfhppeduleegrddvheegrddvgedurddvhedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelgedrvdehgedrvdeguddrvdehtddphhgvlhhopedufedtrdduledtrdekhedrgedvpdhmrghilhhfrhhomheptggrlhhigihtvgdrphgvrhhnohhtsehgrhgvnhhosghlvgdqihhnphdrohhrghdpnhgspghrtghpthhtohepgedprhgtphhtthhopehjihhrihhslhgrsgihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtsehlihigthgvrdgvmhgrihhl
Content-Transfer-Encoding: quoted-printable

Yep, I don't know what went wrong here.

I didn't see the commit you sent to fix this issue, so I tried to send a=20
new patch that fixes the issue, but I somehow sent the wrong patch. Sorry=
.

Thank you for your fix.

On 9/10/25 08:43, Jiri Slaby wrote:
> On 09. 09. 25, 22:26, Calixte Pernot wrote:
>> From: Calixte Pernot <c@lixte.email>
>>
>> Support "\e[?1049h" and "\e[?1049l" escape codes.
>> This patch allows programs to enter and leave alternate screens.
>> This feature is widely available in graphical terminal emulators and=20
>> mostly
>> used by fullscreen terminal-based user interfaces such as text editors=
.
>> Most editors such as vim and nano assume this escape code in not=20
>> supported
>> and will not try to print the escape sequence if TERM=3Dlinux.
>> To try out this patch, run `TERM=3Dxterm-256color vim` inside a VT.
>>
>> Signed-off-by: Calixte Pernot <calixte.pernot@grenoble-inp.org>
>> ---
>> =C2=A0 drivers/tty/vt/vt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 58 ++++++++++++++++++++++++++++++++++
>> =C2=A0 include/linux/console_struct.h |=C2=A0 3 ++
>> =C2=A0 2 files changed, 61 insertions(+)
>>
>> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
>> index 62049ceb3..d9e4eb3f0 100644
>> --- a/drivers/tty/vt/vt.c
>> +++ b/drivers/tty/vt/vt.c
>> @@ -141,6 +141,7 @@ static const struct consw=20
>> *con_driver_map[MAX_NR_CONSOLES];
>> =C2=A0 static int con_open(struct tty_struct *, struct file *);
>> =C2=A0 static void vc_init(struct vc_data *vc, int do_clear);
>> =C2=A0 static void gotoxy(struct vc_data *vc, int new_x, int new_y);
>> +static void restore_cur(struct vc_data *vc);
>> =C2=A0 static void save_cur(struct vc_data *vc);
>> =C2=A0 static void reset_terminal(struct vc_data *vc, int do_clear);
>> =C2=A0 static void con_flush_chars(struct tty_struct *tty);
>> @@ -1344,6 +1345,10 @@ struct vc_data *vc_deallocate(unsigned int=20
>> currcons)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(vc->vc_sc=
reenbuf);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vc_cons[currcon=
s].d =3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 if (vc->vc_saved_screen !=3D NULL) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(vc->vc_saved_screen)=
;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vc->vc_saved_screen =3D NU=
LL;
>> +=C2=A0=C2=A0=C2=A0 }
>
> Yes, that's the bug. (I am not sure why are you sending this?)
>
> thanks,

