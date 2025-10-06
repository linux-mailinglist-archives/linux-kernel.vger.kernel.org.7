Return-Path: <linux-kernel+bounces-843139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFE8BBE7A0
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 17:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78E871898A5B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 15:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA552D738F;
	Mon,  6 Oct 2025 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PszqrCTG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2169645
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 15:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759764154; cv=none; b=HnTd2gWPsruYRqR0cdENgwhgdkVmNpBJUE2fslyD9Vkvrxifi2x6bvYPD7msy3tWzgwMIgm6aEAQpjf2K+C0wBH/bHAFUdxiciwL5kAzjJF9UGAwa6FaYzvKtgpskQMW7IyzycAL5lEkGWeT1zRONYy1zmLPIrmI8XJw2EELRpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759764154; c=relaxed/simple;
	bh=o8YzxUxFnNxPvWk0LqNOeC1op1tp++oxZzsKSVZ15iI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qxtU8o459K6BAQPXSynCtb5NVhUYAKvs7stXeaVbGfZaRU3FhSTNtUVghigdSWJWx+0QQK+xyqhjlnrZQx8MUyDWFmuKpndIz5AdfYxjg4VU9LblnhXRPyBWmch9zduM48NzNS6oqrU+AIJBpBzBPfIRuUF7vQJAL/JKfVenYHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PszqrCTG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759764150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=o8YzxUxFnNxPvWk0LqNOeC1op1tp++oxZzsKSVZ15iI=;
	b=PszqrCTGiDqG0SFmRwIcshND+fTykYMpNbWAjIEL+k8E2ImDpnO9wyfUde04wHtqDkemqQ
	WQu2RaiHsLK6zveoxMaBjrwhBbGtgpANBmUu3KNgBNr9tsPNrEFMwd4YzsaCyooZdCMR5V
	mWpGS4iPqisYQ83aIJg/NG9rwnEvic8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-IdKlaWu9NJiy5GPhA44PJQ-1; Mon, 06 Oct 2025 11:22:29 -0400
X-MC-Unique: IdKlaWu9NJiy5GPhA44PJQ-1
X-Mimecast-MFC-AGG-ID: IdKlaWu9NJiy5GPhA44PJQ_1759764148
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e407c600eso27092365e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 08:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759764148; x=1760368948;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o8YzxUxFnNxPvWk0LqNOeC1op1tp++oxZzsKSVZ15iI=;
        b=PMcqvhXwoAKDOZeugkvYinY09HhQOadmJ0wgqP9MzywMe2e/QuYwaQemc8cmffEsWb
         djuZPx4T6+E1NzbVlWSdzcqvANkf8cYpwSYcl4LhXcaocexoyxqksD1XlfHWZ+AgSVu3
         EmJV5XssSI+OXNag+64U319hlKWRcH2/Hud+yFlRCcOzLzp9RgujLtvtmkPsdND4vUQ1
         rLwPKYr02qkdD8vQ7iPyhC4JnWiIfVoSR6CLeAlz/JicWD2UAQZaJr/hZ3xVmW/HO1jO
         oJC460G4bn8Tx7bGmnY9w6Ln4LpEsIHtvmpF7kmQlCXy0F/2ZVw3XBzOGqf0nDfTA9NB
         V05Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvJ6ohEaSpfkzDPVmcM/18pUA6cg8PZ5O9YMz2RsbRKrCuek+9HEi+mFduZUNa9XTpDhCO7b2w8Ne1+Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWMFcRYqRlKP/1QiVIZPtmMDiqKOg9FN1LuAawXGni0A3z01AN
	tCHmufKCGgX9H02r1Bbi9Fy+Cv+Zjr3mNDn1kgHjjdOtPYn4vsmawSvuXmFTtKxz8WNaspl1xSZ
	4e/51ITxtF8XMsFjf1JHRCsEPvUZZXw1Bbz6z8g3Vm7oElrA+K4poJEcYIGNm/Tz20Q==
X-Gm-Gg: ASbGncvJTFacJWqPxv1vJ3TtzPKEgb6zzrHlcKORFa7jHWWPRBgPEr7CXn5L1szai8v
	6Ka1bonI5MTgZ/ccTeLygqL/Z/+xs/Dgbz0IQFc7ZVxY1wyYAhnsT7A5MejnKvJMP9LQWoOjw2e
	DTsmvFwEzxNWHihTWkTNdi00VlRVOpAVKKdHYdrULBgROeh7PA1f6jDT4uvcShBilB+wsZbwulj
	gU0k66SdF23bJaIklsKPjDn89wHBBA+5e547LTOjkqnHihSKleRXb1v4VypwDvb4kZhOxdayXdD
	PUuFuRhgdrTmp/7nwdhvYoZ03lB6UmwnRydsWkOfmrRyadjP9iLBxW2YfX0DV3PXLeOe7uo=
X-Received: by 2002:a05:600c:5021:b0:46e:6339:79d1 with SMTP id 5b1f17b1804b1-46e71101a47mr89922765e9.5.1759764148421;
        Mon, 06 Oct 2025 08:22:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2mwPc8nokFrMFFk/wpmeHcRzJl3szCi2nNmnUV6r4dJWW6D8+UGEIG/SOBoDbAm+ZF+g+Ow==
X-Received: by 2002:a05:600c:5021:b0:46e:6339:79d1 with SMTP id 5b1f17b1804b1-46e71101a47mr89922575e9.5.1759764147996;
        Mon, 06 Oct 2025 08:22:27 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8b0068sm21313910f8f.26.2025.10.06.08.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 08:22:27 -0700 (PDT)
Message-ID: <73ddbbbb06f9c8d3325a58f68c81dd574b3c80e0.camel@redhat.com>
Subject: Re: [PATCH v2 11/20] verification/rvgen: Allow spaces in and events
 strings
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Mon, 06 Oct 2025 17:22:26 +0200
In-Reply-To: <87plb0jhdw.fsf@yellow.woof>
References: <20250919140954.104920-1-gmonaco@redhat.com>
	 <20250919140954.104920-12-gmonaco@redhat.com> <87v7kxr2fr.fsf@yellow.woof>
	 <b2eccf79b5ab2b0d4b2f02e048938e923aa6e619.camel@redhat.com>
	 <87plb0jhdw.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-06 at 15:20 +0200, Nam Cao wrote:
> Nah, you can keep it. I was just confused. Now I looked again, it starts
> to make sense.
>=20
> Reviewed-by: Nam Cao <namcao@linutronix.de>
>=20

Alright, thanks!

> I am thinking about converting the entire thing to be ply-based (after
> we are done with this series). It should make things easier to
> follow. Would you object that?

I'm on board with that, I left out some other changes to the parser in ligh=
t of
a major refactoring. I'd just need to see how this thing works but it reall=
y
seems the right thing to do.

Gabriele


