Return-Path: <linux-kernel+bounces-881206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E31AC27B7B
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 10:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3FD33A4A95
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 09:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEA12C11C6;
	Sat,  1 Nov 2025 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="qV83dMGu"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD40CF510
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 09:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761991033; cv=none; b=elU1KLxsj+xa1uHU+gUfB6iMbIaeoOsHliI1mIe6+vkNmBneYKnSUyxuYmT22DICxikQ/PA8Dnu70TQXm17Fpp+9N8ntVf6tFgvY8skOGax5u/ZEIVWZn6jGmD+OA/C3zkjSRO0GL9uyuM5xko7ap7YXM5F7GdwNuOS2PXjgLa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761991033; c=relaxed/simple;
	bh=EZYP2ZGqpOgoKSADv8CU64QeuXYdH8H9uMcFqy7wW8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DzhPm9bYnYoVE0Q5D9v477jW8W8EdG+9RuitDXfPqPBdI6mCm1c9EAzSo7XqNKnjBsvtR3E6rysQCHq5MYgq+RJKrqjyuJ24EhhH3WSaNKOY5hr4g05CP8XFcX/o/Ssf7V+t1FLRCfeME45dFSEwX63CB7YJkWpbS+8b5j06md4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=qV83dMGu; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b6d70df0851so593985766b.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 02:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1761991030; x=1762595830; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OGFt2XQpdp9rBNdBCSOgkWHGSVJBimii0ao4cHcHnEE=;
        b=qV83dMGu+m3VWZFBhubmTgdb9cZHEXkRWo/msSyAtE03L6r53MyS9IWkBp1uCW64Q/
         S45DRUem0IaFD6YfqKbE/Kx0U6EXAfMh2E+DGGyZEB++9qrFcY4V2yiIe/yzAcvfhn6c
         DEZvUFOjPlMCeF+Dm/0rVJUKuM91ZajjeRt8iG4mCxg9dyCQdanWpBm18tmHLn7bGhGR
         DkT8yhyZBCmnTUAKV09/EdqFkuEDxF/si8WqTkI/cHA2u58NHL0lLq5rRrvuQwwZ9tH+
         ZWr1YL4VZcEfHlFC2FN84GA1+Ziy5IlOhKoajqhPswCiPo548m/E+L+pJOPkJ+6GuwmQ
         Fpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761991030; x=1762595830;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OGFt2XQpdp9rBNdBCSOgkWHGSVJBimii0ao4cHcHnEE=;
        b=bne17Ps+NpjZckzK/NFHu0uW3ww3pt81z2o8rrGyDeZavHjACn32pO433rdJcMlaSj
         hKfRqDLOWXxWvl21En1s9Y6bUMcPIz4pz8zDVZoKFQGlSCKNwqEu0orlYkNJclVY7YDN
         jw9fqP43GqrUIr0WavKdqMqNz9kT+3TXTXQnkvKSkgtd2HoYET7PvpRNVxokI/oJ3Yea
         Hcn2zZyHrZZpB+O/uL9t2Dd0q5EQtxaoD1eXtZeGcyMv6Ilav9AT1v1p4LLs0f0aVQsw
         /Q4+EXe5irs8oOp3EiMOVv3IflDKH1T8u1LO6eFUG2bQPSt135Em5u3G4eYEJ2Jsg4Bd
         0I3w==
X-Forwarded-Encrypted: i=1; AJvYcCXmAc3SxfHIwxdYOA3W6qp58z9LxekhhEgD6Mp3b/3dNTzPzrHczfjpE6rB8xqC50/n11KXJNV/wpcROjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhc8ldaAKIPde+qvuMd/g8/Dy3q2HaTNAhgllAZpKxXNAp3QJl
	waeQVxUhzpHLny1z2BEBDl6V4LBx+48DMdAxc3HtSg7x5+ThaB5bwZuETpcFQbpT0NBWHYv25Aa
	YZrsgog3d21qMfv+EUJTrrIWRNpZ6NY4fURch0d9Wrw==
X-Gm-Gg: ASbGncvfe69nlqEDkt181zflv/Sf0ZDdqCaW/YfyUJgMsqUvqc4dn7U8UlDxcdypo29
	x/AmmGzyA1iY1tI++NBGeMPd2WJK31GK0yOCsdSDfbCz31RnAtk+/EcSBoQJI7b4wcQcCVzEu+h
	wzeugsVCcRrVFsy5I4PapwDkmK/jjA8vZhh9FRQhl3QEyXyZNXcyN/t8rA1dOUUkOLPwmgXwFXI
	PTfkL4pNUn9evLOESCvvWwoAmBsGE9QNfikNgPHhN1Up+P2YjHWAN33fx/Ug7KeXXXhln/m
X-Google-Smtp-Source: AGHT+IGs4uAX3yencgx0/XZuSpz5r9hsMQdALphD2vGQGD03EeAm6F6Xe1h2PTXFJBtX+prIK2L0qcVEIjfa4HGQf4Y=
X-Received: by 2002:a17:906:9fc4:b0:b6d:a7ad:2fda with SMTP id
 a640c23a62f3a-b70700b5861mr718340266b.12.1761991029382; Sat, 01 Nov 2025
 02:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031140043.564670400@linuxfoundation.org>
In-Reply-To: <20251031140043.564670400@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Sat, 1 Nov 2025 15:26:31 +0530
X-Gm-Features: AWmQ_bmibL6tpkqJQn24nQT7RZtlAq2etQdeb3xjOE_tEFUjo2XhoVmekwL8ago
Message-ID: <CAG=yYwkDgbkvR0JD4ihRHsPPd1a6oZLaYn+E_0qPKFo6Ugy__A@mail.gmail.com>
Subject: Re: [PATCH 6.17 00/35] 6.17.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	lkml <linux-kernel@vger.kernel.org>, torvalds@linux-foundation.org, 
	Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, 
	Shuah Khan <shuah@kernel.org>, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	Pavel Machek <pavel@denx.de>, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org, 
	sr@sladewatkins.com
Content-Type: multipart/mixed; boundary="00000000000067ab4e06428581f3"

--00000000000067ab4e06428581f3
Content-Type: text/plain; charset="UTF-8"

compiled and  booted  6.17.7-rc1+
dmesg -l warn  shows some,
file   attached

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>


-- 
software  engineer
rajagiri school of engineering and technology

--00000000000067ab4e06428581f3
Content-Type: text/plain; charset="US-ASCII"; name="dmesg-warn.txt"
Content-Disposition: attachment; filename="dmesg-warn.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mhg3x5060>
X-Attachment-Id: f_mhg3x5060

WyAgICAwLjI0NTYxNV0gVk1TQ0FQRTogU01UIG9uLCBTVElCUCBpcyByZXF1aXJlZCBmb3IgZnVs
bCBwcm90ZWN0aW9uLiBTZWUgaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3Qv
YWRtaW4tZ3VpZGUvaHctdnVsbi92bXNjYXBlLmh0bWwgZm9yIG1vcmUgZGV0YWlscy4KWyAgICAw
LjU3MzQyOV0gQ291bGQgbm90IHJldHJpZXZlIHBlcmYgY291bnRlcnMgKC0xOSkKWyAgICAwLjY0
NTczMl0gaTgwNDI6IFBOUDogUFMvMiBhcHBlYXJzIHRvIGhhdmUgQVVYIHBvcnQgZGlzYWJsZWQs
IGlmIHRoaXMgaXMgaW5jb3JyZWN0IHBsZWFzZSBib290IHdpdGggaTgwNDIubm9wbnAKWyAgIDE1
LjY1ODM2Nl0gYW1kZ3B1IDAwMDA6MDQ6MDAuMDogYW1kZ3B1OiBmYWlsZWQgdG8gbG9hZCB1Y29k
ZSBSTENfUkVTVE9SRV9MSVNUX0NOVEwoMHgyOSkgClsgICAxNS42NTgzNzBdIGFtZGdwdSAwMDAw
OjA0OjAwLjA6IGFtZGdwdTogcHNwIGdmeCBjb21tYW5kIExPQURfSVBfRlcoMHg2KSBmYWlsZWQg
YW5kIHJlc3BvbnNlIHN0YXR1cyBpcyAoMHhGRkZGMzAwRikKWyAgIDE1LjY1ODkwM10gYW1kZ3B1
IDAwMDA6MDQ6MDAuMDogYW1kZ3B1OiBmYWlsZWQgdG8gbG9hZCB1Y29kZSBSTENfUkVTVE9SRV9M
SVNUX0dQTV9NRU0oMHgyQSkgClsgICAxNS42NTg5MDddIGFtZGdwdSAwMDAwOjA0OjAwLjA6IGFt
ZGdwdTogcHNwIGdmeCBjb21tYW5kIExPQURfSVBfRlcoMHg2KSBmYWlsZWQgYW5kIHJlc3BvbnNl
IHN0YXR1cyBpcyAoMHhGRkZGMDAwRikKWyAgIDE1LjY1OTQzOV0gYW1kZ3B1IDAwMDA6MDQ6MDAu
MDogYW1kZ3B1OiBmYWlsZWQgdG8gbG9hZCB1Y29kZSBSTENfUkVTVE9SRV9MSVNUX1NSTV9NRU0o
MHgyQikgClsgICAxNS42NTk0NDJdIGFtZGdwdSAwMDAwOjA0OjAwLjA6IGFtZGdwdTogcHNwIGdm
eCBjb21tYW5kIExPQURfSVBfRlcoMHg2KSBmYWlsZWQgYW5kIHJlc3BvbnNlIHN0YXR1cyBpcyAo
MHhGRkZGMDAwRikKWyAgIDE4Ljk5NzM5MF0gc3lzdGVtZC1zeXN2LWdlbmVyYXRvclszMzFdOiBT
eXNWIHNlcnZpY2UgJy9ldGMvaW5pdC5kL2xwZCcgbGFja3MgYSBuYXRpdmUgc3lzdGVtZCB1bml0
IGZpbGUsIGF1dG9tYXRpY2FsbHkgZ2VuZXJhdGluZyBhIHVuaXQgZmlsZSBmb3IgY29tcGF0aWJp
bGl0eS4KWyAgIDE4Ljk5NzM5N10gc3lzdGVtZC1zeXN2LWdlbmVyYXRvclszMzFdOiBQbGVhc2Ug
dXBkYXRlIHBhY2thZ2UgdG8gaW5jbHVkZSBhIG5hdGl2ZSBzeXN0ZW1kIHVuaXQgZmlsZS4KWyAg
IDE4Ljk5NzQwMF0gc3lzdGVtZC1zeXN2LWdlbmVyYXRvclszMzFdOiAhIFRoaXMgY29tcGF0aWJp
bGl0eSBsb2dpYyBpcyBkZXByZWNhdGVkLCBleHBlY3QgcmVtb3ZhbCBzb29uLiAhClsgICAxOC45
OTkyNzRdIHN5c3RlbWQtc3lzdi1nZW5lcmF0b3JbMzMxXTogU3lzViBzZXJ2aWNlICcvZXRjL2lu
aXQuZC9saWdodGRtJyBsYWNrcyBhIG5hdGl2ZSBzeXN0ZW1kIHVuaXQgZmlsZSwgYXV0b21hdGlj
YWxseSBnZW5lcmF0aW5nIGEgdW5pdCBmaWxlIGZvciBjb21wYXRpYmlsaXR5LgpbICAgMTguOTk5
Mjc5XSBzeXN0ZW1kLXN5c3YtZ2VuZXJhdG9yWzMzMV06IFBsZWFzZSB1cGRhdGUgcGFja2FnZSB0
byBpbmNsdWRlIGEgbmF0aXZlIHN5c3RlbWQgdW5pdCBmaWxlLgpbICAgMTguOTk5MjgxXSBzeXN0
ZW1kLXN5c3YtZ2VuZXJhdG9yWzMzMV06ICEgVGhpcyBjb21wYXRpYmlsaXR5IGxvZ2ljIGlzIGRl
cHJlY2F0ZWQsIGV4cGVjdCByZW1vdmFsIHNvb24uICEKWyAgIDE5LjAwNDExMV0gc3lzdGVtZC1z
eXN2LWdlbmVyYXRvclszMzFdOiBTeXNWIHNlcnZpY2UgJy9ldGMvaW5pdC5kL2ZldGNobWFpbCcg
bGFja3MgYSBuYXRpdmUgc3lzdGVtZCB1bml0IGZpbGUsIGF1dG9tYXRpY2FsbHkgZ2VuZXJhdGlu
ZyBhIHVuaXQgZmlsZSBmb3IgY29tcGF0aWJpbGl0eS4KWyAgIDE5LjAwNDExNl0gc3lzdGVtZC1z
eXN2LWdlbmVyYXRvclszMzFdOiBQbGVhc2UgdXBkYXRlIHBhY2thZ2UgdG8gaW5jbHVkZSBhIG5h
dGl2ZSBzeXN0ZW1kIHVuaXQgZmlsZS4KWyAgIDE5LjAwNDExOV0gc3lzdGVtZC1zeXN2LWdlbmVy
YXRvclszMzFdOiAhIFRoaXMgY29tcGF0aWJpbGl0eSBsb2dpYyBpcyBkZXByZWNhdGVkLCBleHBl
Y3QgcmVtb3ZhbCBzb29uLiAhClsgICAyNC40NjM5OTldIG52bWUgbnZtZTA6IHVzaW5nIHVuY2hl
Y2tlZCBkYXRhIGJ1ZmZlcgpbICAgMjguMTc0OTc5XSBrYXVkaXRkX3ByaW50a19za2I6IDEyNiBj
YWxsYmFja3Mgc3VwcHJlc3NlZAo=
--00000000000067ab4e06428581f3--

