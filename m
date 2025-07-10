Return-Path: <linux-kernel+bounces-726534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3C7B00E42
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7161C86701
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 21:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3825F291C2E;
	Thu, 10 Jul 2025 21:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GCMk6nxO"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EEF23506E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 21:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752184726; cv=none; b=dB/GVCOWPDz3NkktzXPCeBmw7BFxDnFu2vQfQOZbUcwCcMCRiCHWSNQMdOGYdqHlHXNerNlwDZYT5Y0vdc13HnlOFsQBw50r/J1Edqm+ONQgFdhARcaF4pT1bRsP+DRk8oRGaGGXJ1kn97qwOiQVmhkGiupAo1xo+ds/x2Z96Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752184726; c=relaxed/simple;
	bh=ylyRbKljNFjJtaMPwqP1eMnpQYJpOhfIDXsclrUxY9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kKnmogsylbnqDcbHjK4SSJBBy1Z4OIe3Eg/auJANrmdHLseDOVyX52bgmFvFyOJcVQ6SUGixGcgaoQUusS6I/k+JIhNgRYegCJD0S/GED6x1SwNHAoDyM3CvNm+a0bje1xY4syYnY8qYK+l9IvIj3uzrY6miKAMD9GNESlOvKsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GCMk6nxO; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae0d7b32322so224889466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 14:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752184722; x=1752789522; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NOhvg1l0t2LaUB8HzcyN7Tq+OVNAbmeCuPM6bN+kiYw=;
        b=GCMk6nxOkdyd2pamGnxs2GgAP1wWSpPqc8tobUfC1faYtSfVezeQ3IRI1Ffto/UjZ2
         JAP5rHgxclbnTjFevxf1a30mqs5c887ziLgbhgJzb92OpCbXYGmsKm2wMVUqx+MdxbvI
         NWsuiXFbmyMtUuC2p9Uk4kyKHbRxPzjsDPLBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752184722; x=1752789522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NOhvg1l0t2LaUB8HzcyN7Tq+OVNAbmeCuPM6bN+kiYw=;
        b=ud3mkIXQfKqTRpcFBHPOkZlihapGRvy6ZfRly0A/kNIpQB3/uf86xzdZsDJf7QLI0Y
         wDV1sasO7afc6R92p1G17ynNa+uZdZRrTQZslH0s2c5kIw+ilvIbr40g+EKroY+Ahu45
         iDIsnp7gHTyVvXTRg7423HhMXw+zTFUN3dYT3ltjn2tDdlzLtNxRFHfJDxNiVJOJO+5Q
         pStwNmzbnijqiY/EAaK2fjI6Fb4d1SSRNL8abCkBd8rddIpJBw9xq6FmoKa0y09WhQlZ
         jc+G0tmL6hvEKi1mGiUPFqOnR9wLWlMvd+z9SpyKZEI1rEPIsvedq7a9TEQ9JBU59zqK
         vRAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjpVpbXX1/qur7lqNC/DbbyP1ofYsI+FH7q8gLn1vjdwv6Hj4mgg+cHzpDItAuMv91lsMvi8IkZOjHjtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyvkOdD8e411VjcNMp1rg7TOjpBhvl2t+F2Mjy/W1/7dUPloeJ
	F09aO+41/2PLN9QFL4nBNVdAoHKxUP1ENoBkCiZzflAlVI2QSD2ukpWY0ZGCU46gKphJeFgWcjo
	O4MHVfHs=
X-Gm-Gg: ASbGncuTXUM8O0ng+TAqS3glCPGUo/q7LV4CjXQE8khA0lfrXPfXSJGnBEBOyq8hQqq
	pX1tmd6IFuRIKtcNRcQPfm9FtrXElph6cofYF18QnrN2O1yKDJfoPDgYun8LNfSmgZaihn9018D
	ahRFaRdwGklZ3I7kOh5b/NxmTMV2Yk36sjlI2lq2Yej9TMVpLFdSsaDFuoPEpAsd7J/x0lXsxXL
	juPyhr68aMCxa4AYAJfQdbzpSAv8Zq53+rhZ2Nci4bjRCcqIeCuoj6zGEaZd+3GoBgAwuCy9JVo
	FvzmfgVARnPulBzM1f4wLE2OqIBLaV51WGmAj9adsaRSTH6/Pf7OEb5mhXStRWoEfn/E/Y5h+xB
	tqkhOVtzCGDFusNOSFiP4n8je4hodkPdwGPTe
X-Google-Smtp-Source: AGHT+IGNl74S0VPQH1vvAizWFzYnOLeMwjzgCziwfilCO1s82hZCGXmpDYLmHiEabfrRVMXZwKu6Zg==
X-Received: by 2002:a17:906:9fcd:b0:ae3:595f:91a0 with SMTP id a640c23a62f3a-ae6fbfaa5e5mr84542266b.16.1752184722166;
        Thu, 10 Jul 2025 14:58:42 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82de902sm193703866b.147.2025.07.10.14.58.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 14:58:41 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so2373070a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 14:58:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVcmRq4twChcdtJAOxI7fB+gmRvZ5JX5ldT46o9ldI5JRzICtPNBKxPxlojWloIaAt5gVV3iEh/lhk7VS8=@vger.kernel.org
X-Received: by 2002:a05:6402:289c:b0:607:206f:a19 with SMTP id
 4fb4d7f45d1cf-611e84a9aa4mr389972a12.25.1752184721009; Thu, 10 Jul 2025
 14:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751823326.git.alx@kernel.org> <cover.1752182685.git.alx@kernel.org>
 <04c1e026a67f1609167e834471d0f2fe977d9cb0.1752182685.git.alx@kernel.org>
In-Reply-To: <04c1e026a67f1609167e834471d0f2fe977d9cb0.1752182685.git.alx@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 10 Jul 2025 14:58:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiNJQ6dVU8t7oM0sFpSqxyK8JZQXV5NGx7h+AE0PY4kag@mail.gmail.com>
X-Gm-Features: Ac12FXwFBMXaxRHdcUswF9pkpuvbALmMtsHBeK-c4iMg5ugUB_Hn2l67aUaOXFU
Message-ID: <CAHk-=wiNJQ6dVU8t7oM0sFpSqxyK8JZQXV5NGx7h+AE0PY4kag@mail.gmail.com>
Subject: Re: [RFC v5 6/7] sprintf: Add [v]sprintf_array()
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, 
	Dmitry Vyukov <dvyukov@google.com>, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Michal Hocko <mhocko@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Martin Uecker <uecker@tugraz.at>, Sam James <sam@gentoo.org>, Andrew Pinski <pinskia@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Jul 2025 at 14:31, Alejandro Colomar <alx@kernel.org> wrote:
>
> These macros are essentially the same as the 2-argument version of
> strscpy(), but with a formatted string, and returning a pointer to the
> terminating '\0' (or NULL, on error).

No.

Stop this garbage.

You took my suggestion, and then you messed it up.

Your version of sprintf_array() is broken. It evaluates 'a' twice.
Because unlike ARRAY_SIZE(), your broken ENDOF() macro evaluates the
argument.

And you did it for no reason I can see. You said that you wanted to
return the end of the resulting string, but the fact is, not a single
user seems to care, and honestly, I think it would be wrong to care.
The size of the result is likely the more useful thing, or you could
even make these 'void' or something.

But instead you made the macro be dangerous to use.

This kind of churn is WRONG. It _looks_ like a cleanup that doesn't
change anything, but then it has subtle bugs that will come and bite
us later because you did things wrong.

I'm NAK'ing all of this. This is BAD. Cleanup patches had better be
fundamentally correct, not introduce broken "helpers" that will make
for really subtle bugs.

Maybe nobody ever ends up having that first argument with a side
effect. MAYBE. It's still very very wrong.

                Linus

