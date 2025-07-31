Return-Path: <linux-kernel+bounces-751935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A52B16F9C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 174D317EF05
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD9922F74D;
	Thu, 31 Jul 2025 10:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="0bcLZnU3"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA542264AE
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753957871; cv=none; b=Zl6hOILJJfQejOU7Vj2ppNuWQVF+TxT3ZTr5tCjd/lRexpVD0arI7dbslOKKQEKWSYRPAYU0X2o+qSEpadO40kxB4PmB5rVDhJumV9AgyErLmmWqG/tieCvOzDQ/ttHfDA4EI64Zpxrli881X8XFh/BXWBeMe1SrKIbCOApIu54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753957871; c=relaxed/simple;
	bh=ZUDRaqnU24X+T7uVJpSv5R4hg3CFDsxJ4xG56N/y4Qg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QALa5ot+AaMF4hNVBngge0UQxoET6J36LEcPIUzhK+DhZPAHKy1ssXsdYc0KExZY3bTMXzVFKZ8mnDe8k4MHTHDSK7456HN2gZcyT8cb27XwSdrkwkUSwXE4JADa0vc+n91zubNSKGtBYywwhreBbIyD4xHDUf1b56hz2S/pG80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=0bcLZnU3; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61539e2065dso3014489a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1753957868; x=1754562668; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4guNMFO2mNbUVAujgFMPCeQwDaxzkTETmATTN/1vzk=;
        b=0bcLZnU3r7oR3VeHpMNKjhZCr4QAam/3A7YxEhGTUYHWnkjIT9JTOfEJBRIpxMjkfW
         D0mkWCxlYVSS4JfIC8MM6WBrzBZNCzrOS+BecYrKfvzPu2UIyh1pPgzyCIDtEUZvVd/e
         UpNqjOZVzSl+xdLOEfr1d+sHMajDBmGPC/HIcDA4J/jCWeyWDZKJrUiQuTOGhkjT++T3
         0mQsudHeb+EY2jZcOdX8MPll9k9iLMz31MI4BP34ObVUgDEaw32dg5foXOEMMqJf/vwP
         7FtmkuVa8AFUrX5/EydyDNVXWz+fwQYDlIjp0we3zN/WKgYUjBAYKP8Z/nkhb5uf73pV
         bWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753957868; x=1754562668;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L4guNMFO2mNbUVAujgFMPCeQwDaxzkTETmATTN/1vzk=;
        b=bXOSZxx25Kskhrm+9zNp8D3scq+kPUAvnLVf5jBGODznUT/3xyK7XQ4WbA/1gm+sUH
         XfdaxSkkxboMsr4LJMVihTMdNOyPIqK4cyd59u38HJdMRxJfTsDbk8sTzWttVfHXVfFw
         SqW9fHgCzGjNiRywvScOiUHIgzUAzwXd+Uk4IQTbT6hVagKo18J0NIAUdDVl2/5+s1AW
         mib+3zzL+EValMKyWiNwQFqQW9TRAZyzC6IbssP6OjdmmjaS7mJ/EEDHmb9Jsv4kcyNM
         xh7YnfyvlqnQzlMIzee/TjUeQ+MuDXPhW/ObzJquGws0a8q9O1h/eyo3oFilTXlGpOSd
         M0IA==
X-Forwarded-Encrypted: i=1; AJvYcCW+vTE5CoUjoaQkJlge5L2u8FYyFOJb/C3YGphtI+vTIgCSOkx7guojrF0Cg/qPcmg2n/XKwDHh4mIEd88=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfUk7W2hlsh51TeUkK2qrc/TLlKXGC2922Y29ZQ+W3sSsuhhxg
	wNPJhdBNXHrSjyPdtsnNRzV0Ft1ojcrU07I7XEuIPvbAbDk13anZafeUqVUdIrGUsEk=
X-Gm-Gg: ASbGncv9jzfURPxWfyBow8VgfBRwWdia+y46CjdDoUFHrgeE/qiDrzPZvk4EOKEgbHA
	1nQr9m3IZPbNM/3HftvzZ41C77kCn+yUS4F56nrMg8xb4DdeuNdSJHLeNs+JNXC7+3AXoTjLMkp
	AZVXj5C4/AoRSdc+c30R/BRWexzxTgOeJVtY+//3lYmTVqFqyrRSM4JsMJYRKDRVEWhU6US1OS7
	8oDlB989NXHX+iCAI1c0GnBtwfLj4J+CfZe1rOpgbXMm5ZCqVx8fXlL9xwnfwTRJxacvj4oYbTG
	wdKG1tAA2PUFDQ6HqNrUAiXZKxLjJ65qMc+lCszbGpLJo+bn+yxsurDI7tyOJXl7/5BHmr7qeE6
	z4gBUx80N3XXM8FHRVnGrFnC4khNZhh2mdJTW4gpswOxL+S1NticYNdX7HYHbyVXL1rc7VwZJ/8
	yM+g==
X-Google-Smtp-Source: AGHT+IFmHbj//ifYv0ps4iK3o2MK/SZVcRme2djqmVaHUnfsmz5EX4ncIp+nUgle+xZrZADbwlYiEw==
X-Received: by 2002:a17:907:2d28:b0:ae9:c8f6:bd3 with SMTP id a640c23a62f3a-af91bc55e14mr166781766b.7.1753957867841;
        Thu, 31 Jul 2025 03:31:07 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f25739sm916887a12.21.2025.07.31.03.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 03:31:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Jul 2025 12:31:07 +0200
Message-Id: <DBQ668L792QL.2OV5Y4G1PDZLR@fairphone.com>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: ipa: add IPA v5.1 and v5.5 to ipa_version_string()
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Alex Elder" <elder@ieee.org>, "Alex Elder" <elder@kernel.org>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250728-ipa-5-1-5-5-version_string-v1-1-d7a5623d7ece@fairphone.com> <e07f0407-84e1-4efa-868d-5853b7e9ab4e@ieee.org>
In-Reply-To: <e07f0407-84e1-4efa-868d-5853b7e9ab4e@ieee.org>

On Mon Jul 28, 2025 at 5:53 PM CEST, Alex Elder wrote:
> On 7/28/25 3:35 AM, Luca Weiss wrote:
>> Handle the case for v5.1 and v5.5 instead of returning "0.0".
>
> This makes sense for IPA v5.5.
>
> I have comments below, but I'll do this up front:
>
> Reviewed-by: Alex Elder <elder@riscstar.com>

Thanks!

>
>> Also reword the comment below since I don't see any evidence of such a
>> check happening, and - since 5.5 has been missing - can happen.
>
> You are correct.  Commit dfdd70e24e388 ("net: ipa: kill
> ipa_version_supported()") removed the test that guaranteed
> that the version would be good.  So your comment update
> should have done then.
>
>> Fixes: 3aac8ec1c028 ("net: ipa: add some new IPA versions")
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>>   drivers/net/ipa/ipa_sysfs.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/net/ipa/ipa_sysfs.c b/drivers/net/ipa/ipa_sysfs.c
>> index a59bd215494c9b7cbdd1f000d9f23e100c18ee1e..a53e9e6f6cdf50103e94e496=
fd06b55636ba02f4 100644
>> --- a/drivers/net/ipa/ipa_sysfs.c
>> +++ b/drivers/net/ipa/ipa_sysfs.c
>> @@ -37,8 +37,12 @@ static const char *ipa_version_string(struct ipa *ipa=
)
>>   		return "4.11";
>>   	case IPA_VERSION_5_0:
>>   		return "5.0";
>> +	case IPA_VERSION_5_1:
>> +		return "5.1";
>
> IPA v5.1 is not actually supported yet, and this won't be
> used until it is.  Only those platforms with compatible
> strings defined in the ipa_match array in "ipa_main.c" will
> probe successfully.
>
> That said...  I guess it's OK to define this at the same time
> things are added to enum ipa_version.  There are still too
> many little things like this that need to be updated when a
> new version is supported.

Yeah, my point in adding this as well was based on the comment there:

/**
 * [...]
 * Defines the version of IPA (and GSI) hardware present on the platform.
 * Please update ipa_version_string() whenever a new version is added.
 */
enum ipa_version {
    [...]
}

I previously only noticed 5.5 being missing, but before sending I double
checked if anything else was missing and found 5.1. So perhaps if 5.1 is
not going to be added anytime soon, we could remove the 5.1 definition
and the rest.

>
> Thanks for the patch.
>
> 					-Alex
>
>> +	case IPA_VERSION_5_5:
>> +		return "5.5";
>>   	default:
>> -		return "0.0";	/* Won't happen (checked at probe time) */
>> +		return "0.0";	/* Should not happen */
>>   	}
>>   }
>>  =20
>>=20
>> ---
>> base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
>> change-id: 20250728-ipa-5-1-5-5-version_string-a557dc8bd91a
>>=20
>> Best regards,


