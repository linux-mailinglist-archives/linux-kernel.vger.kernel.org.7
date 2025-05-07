Return-Path: <linux-kernel+bounces-637546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E110AADA83
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 10:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 450A13A8A01
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 08:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C1B1FC109;
	Wed,  7 May 2025 08:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="jJ/yHaJj"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FB620B1F5
	for <linux-kernel@vger.kernel.org>; Wed,  7 May 2025 08:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746607853; cv=none; b=O36ANhruR+OW5RiWTDJcsj4hqs8AdgSXG4NDgD3PylCw9S2dzJKmWaFOZuS0nS5hkt8Z1PAhREAe5hDoAlSQJ8lm84Q1aDT3ttR4nFOEXPyxO3iD6N41TheJJw+uFbCtaVPlxqjbKzHm5cK8QeEPOslzkjQYh9NtN3BOwpnRiSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746607853; c=relaxed/simple;
	bh=mybXQgzHz8kROBrPRKYErCQsmosxck2ounviyFfliF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=acN5vxNOV2qAzmEF4X5RfyT5DQGTqL/NfR4rp0f/fD+bNHngeXS8mmfRbvjnbTTmgliLNsqUleLeFQOe+arWVcevJqnenXxu6GRR/PejEWH3x4WTxxpmMAo64ncPw/SnQ6XQsEQvH105elUR8wDBaMsvWqQQ2SGBT9UicQ1fC8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=jJ/yHaJj; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-441ab63a415so66284395e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 May 2025 01:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1746607850; x=1747212650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3dWRbDpfOQc9VG9II13qarp6JnuKGD1XvHGR672drsA=;
        b=jJ/yHaJjv1qtEyoSqZbFqiJb+G6IPm3LAtvgnGNEaxrnOG7YQgV5bAMatRO109D8nM
         rnjMsoPShK32bZ13vXsZ94bk++MC0/c/iQCy53oGV6qpJuFNidBfkw/zx3sDNR5MruQE
         EeQSdRCANTTX6jAM8p51rbROHhx9NLkmuD+1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746607850; x=1747212650;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dWRbDpfOQc9VG9II13qarp6JnuKGD1XvHGR672drsA=;
        b=Yyk9ULWclH9MpQXmW6q7kY/v1XCyqyFcqEl6PRHYKIeJ5BCPYQFTnqCjsvhHOAPV7f
         kxxEKF8OYN+kz39wsJdV29TcHr2+WeATXnTpOeyQ+ywcAng7Y68mY0MI+TP6DJ32CFXr
         qePfiNW86ggbr/I+99J4Rw18irh8mCDho9CRq/F8jPWwKdQ7agL/313dJ4aWmRxS3fxZ
         1K7824fNiShEQGXDCNKPCAh+Gxhk4PY4R8YUX7yzSLd6vynUnVIq2gjQby4Bgijti0cA
         g7P/LgJ8brp1dWskY9aBQ/+Jjs6OlMTUajqjmHHeqO78rMLYWxXZhNp0gCbWw/HbFpze
         rTlg==
X-Forwarded-Encrypted: i=1; AJvYcCWFw1+BuOM3pZnaHBPirB2aM9ZEu1sWAFez1h/hMHfw3biu4k4yn7g/VLr/2fMKCQEXCtw91e08AIieK50=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCkxkuSikukz9xHDHLMKfYbjP080cNfKfrtTszDU6RWYmT8bBv
	KrYZbnFDnPCAPJrAXuGRQxxs+ZWi2QQB1aLVqeCWpkUx50BWUQiXpFQB/pnXLx8=
X-Gm-Gg: ASbGncs4CQPSIRgCJcH0eDuMRCRh3pE5hApy1ytCMJ1BdpV6WmP9Ob4114OkolaWeRr
	TCvEvkZfObHslGGSFGm5KUv1qjNMWIRQ0ITyLBAsTss3IqilrpWMhflGkLGdwIn918HC/cyEtx6
	PyDhOp5S9pt5u0DeSJfzJAXXPdZRrtYWMfSzMuiwpHTWonLDrS7SKaVzosnCRWMEnZY9b50qegZ
	2fMevvzdO1cK9Cqei9a48c5SMZfGra9gG02XI6KsZozqNJH11CoZ2i5kuB4eczedRX4zz9xpw59
	60G+0dvVkmGjdvdUqYuvRuyzSvmO/aKNAQ2G6M/XLSQoTqbfSw9qrrRzhoFQrLTD0EH+uLIUuUa
	P/7WyVA==
X-Google-Smtp-Source: AGHT+IEW590bSYpslV/nqN30U2PebcR+bm4TVT3XzDprAJtC3P2u/FG+Sa2YFsKEJpH49B6aQNpzpQ==
X-Received: by 2002:a05:600c:1c97:b0:43c:ec0a:ddfd with SMTP id 5b1f17b1804b1-441d44bbfb1mr15956565e9.6.1746607849667;
        Wed, 07 May 2025 01:50:49 -0700 (PDT)
Received: from [192.168.1.183] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b16ec6sm15822494f8f.83.2025.05.07.01.50.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 01:50:49 -0700 (PDT)
Message-ID: <6b0c87e0-d98d-4394-85bd-8abf556ebf0f@citrix.com>
Date: Wed, 7 May 2025 09:50:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/26] x86/cpu: Sanitize CPUID(0x80000000) output
To: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
 John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
 x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
References: <20250506050437.10264-1-darwi@linutronix.de>
 <20250506050437.10264-3-darwi@linutronix.de>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 xsFNBFLhNn8BEADVhE+Hb8i0GV6mihnnr/uiQQdPF8kUoFzCOPXkf7jQ5sLYeJa0cQi6Penp
 VtiFYznTairnVsN5J+ujSTIb+OlMSJUWV4opS7WVNnxHbFTPYZVQ3erv7NKc2iVizCRZ2Kxn
 srM1oPXWRic8BIAdYOKOloF2300SL/bIpeD+x7h3w9B/qez7nOin5NzkxgFoaUeIal12pXSR
 Q354FKFoy6Vh96gc4VRqte3jw8mPuJQpfws+Pb+swvSf/i1q1+1I4jsRQQh2m6OTADHIqg2E
 ofTYAEh7R5HfPx0EXoEDMdRjOeKn8+vvkAwhviWXTHlG3R1QkbE5M/oywnZ83udJmi+lxjJ5
 YhQ5IzomvJ16H0Bq+TLyVLO/VRksp1VR9HxCzItLNCS8PdpYYz5TC204ViycobYU65WMpzWe
 LFAGn8jSS25XIpqv0Y9k87dLbctKKA14Ifw2kq5OIVu2FuX+3i446JOa2vpCI9GcjCzi3oHV
 e00bzYiHMIl0FICrNJU0Kjho8pdo0m2uxkn6SYEpogAy9pnatUlO+erL4LqFUO7GXSdBRbw5
 gNt25XTLdSFuZtMxkY3tq8MFss5QnjhehCVPEpE6y9ZjI4XB8ad1G4oBHVGK5LMsvg22PfMJ
 ISWFSHoF/B5+lHkCKWkFxZ0gZn33ju5n6/FOdEx4B8cMJt+cWwARAQABzSlBbmRyZXcgQ29v
 cGVyIDxhbmRyZXcuY29vcGVyM0BjaXRyaXguY29tPsLBegQTAQgAJAIbAwULCQgHAwUVCgkI
 CwUWAgMBAAIeAQIXgAUCWKD95wIZAQAKCRBlw/kGpdefoHbdD/9AIoR3k6fKl+RFiFpyAhvO
 59ttDFI7nIAnlYngev2XUR3acFElJATHSDO0ju+hqWqAb8kVijXLops0gOfqt3VPZq9cuHlh
 IMDquatGLzAadfFx2eQYIYT+FYuMoPZy/aTUazmJIDVxP7L383grjIkn+7tAv+qeDfE+txL4
 SAm1UHNvmdfgL2/lcmL3xRh7sub3nJilM93RWX1Pe5LBSDXO45uzCGEdst6uSlzYR/MEr+5Z
 JQQ32JV64zwvf/aKaagSQSQMYNX9JFgfZ3TKWC1KJQbX5ssoX/5hNLqxMcZV3TN7kU8I3kjK
 mPec9+1nECOjjJSO/h4P0sBZyIUGfguwzhEeGf4sMCuSEM4xjCnwiBwftR17sr0spYcOpqET
 ZGcAmyYcNjy6CYadNCnfR40vhhWuCfNCBzWnUW0lFoo12wb0YnzoOLjvfD6OL3JjIUJNOmJy
 RCsJ5IA/Iz33RhSVRmROu+TztwuThClw63g7+hoyewv7BemKyuU6FTVhjjW+XUWmS/FzknSi
 dAG+insr0746cTPpSkGl3KAXeWDGJzve7/SBBfyznWCMGaf8E2P1oOdIZRxHgWj0zNr1+ooF
 /PzgLPiCI4OMUttTlEKChgbUTQ+5o0P080JojqfXwbPAyumbaYcQNiH1/xYbJdOFSiBv9rpt
 TQTBLzDKXok86M7BTQRS4TZ/ARAAkgqudHsp+hd82UVkvgnlqZjzz2vyrYfz7bkPtXaGb9H4
 Rfo7mQsEQavEBdWWjbga6eMnDqtu+FC+qeTGYebToxEyp2lKDSoAsvt8w82tIlP/EbmRbDVn
 7bhjBlfRcFjVYw8uVDPptT0TV47vpoCVkTwcyb6OltJrvg/QzV9f07DJswuda1JH3/qvYu0p
 vjPnYvCq4NsqY2XSdAJ02HrdYPFtNyPEntu1n1KK+gJrstjtw7KsZ4ygXYrsm/oCBiVW/OgU
 g/XIlGErkrxe4vQvJyVwg6YH653YTX5hLLUEL1NS4TCo47RP+wi6y+TnuAL36UtK/uFyEuPy
 wwrDVcC4cIFhYSfsO0BumEI65yu7a8aHbGfq2lW251UcoU48Z27ZUUZd2Dr6O/n8poQHbaTd
 6bJJSjzGGHZVbRP9UQ3lkmkmc0+XCHmj5WhwNNYjgbbmML7y0fsJT5RgvefAIFfHBg7fTY/i
 kBEimoUsTEQz+N4hbKwo1hULfVxDJStE4sbPhjbsPCrlXf6W9CxSyQ0qmZ2bXsLQYRj2xqd1
 bpA+1o1j2N4/au1R/uSiUFjewJdT/LX1EklKDcQwpk06Af/N7VZtSfEJeRV04unbsKVXWZAk
 uAJyDDKN99ziC0Wz5kcPyVD1HNf8bgaqGDzrv3TfYjwqayRFcMf7xJaL9xXedMcAEQEAAcLB
 XwQYAQgACQUCUuE2fwIbDAAKCRBlw/kGpdefoG4XEACD1Qf/er8EA7g23HMxYWd3FXHThrVQ
 HgiGdk5Yh632vjOm9L4sd/GCEACVQKjsu98e8o3ysitFlznEns5EAAXEbITrgKWXDDUWGYxd
 pnjj2u+GkVdsOAGk0kxczX6s+VRBhpbBI2PWnOsRJgU2n10PZ3mZD4Xu9kU2IXYmuW+e5KCA
 vTArRUdCrAtIa1k01sPipPPw6dfxx2e5asy21YOytzxuWFfJTGnVxZZSCyLUO83sh6OZhJkk
 b9rxL9wPmpN/t2IPaEKoAc0FTQZS36wAMOXkBh24PQ9gaLJvfPKpNzGD8XWR5HHF0NLIJhgg
 4ZlEXQ2fVp3XrtocHqhu4UZR4koCijgB8sB7Tb0GCpwK+C4UePdFLfhKyRdSXuvY3AHJd4CP
 4JzW0Bzq/WXY3XMOzUTYApGQpnUpdOmuQSfpV9MQO+/jo7r6yPbxT7CwRS5dcQPzUiuHLK9i
 nvjREdh84qycnx0/6dDroYhp0DFv4udxuAvt1h4wGwTPRQZerSm4xaYegEFusyhbZrI0U9tJ
 B8WrhBLXDiYlyJT6zOV2yZFuW47VrLsjYnHwn27hmxTC/7tvG3euCklmkn9Sl9IAKFu29RSo
 d5bD8kMSCYsTqtTfT6W4A3qHGvIDta3ptLYpIAOD2sY3GYq2nf3Bbzx81wZK14JdDDHUX2Rs
 6+ahAA==
In-Reply-To: <20250506050437.10264-3-darwi@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/05/2025 6:04 am, Ahmed S. Darwish wrote:
> CPUID(0x80000000).EAX returns the max extended CPUID leaf available.  On
> x86-32 machines

How certain are you that it's all 32bit CPUs?  AIUI, it's an Intel
specific behaviour, not shared by other x86 vendors of the same era.

~Andrew

