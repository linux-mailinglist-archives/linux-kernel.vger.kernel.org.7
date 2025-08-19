Return-Path: <linux-kernel+bounces-775518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D775CB2C01A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC0AE5851F3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41EB326D7E;
	Tue, 19 Aug 2025 11:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="JwWmsFrl"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA432DE1FC
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602330; cv=none; b=ldgOKCX1MxiQtvv5uk2xgNyb8RGUAlo3tdCDfzl5Ygm+O0JCo4PU93D1MBWDN+E/iNRvNf9KyyEezMIa9R49IbVZeZ98IunW1DT5yhsAt7S6XdXuHnb6NNPO5ybgthsPQUmUF0lr28LP3hSHu6wypDqmjd5q+HzSgQ1or0y0Mv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602330; c=relaxed/simple;
	bh=QrP5cL+eETrcMxbXSVJsF9Sz8/6e5/Smd7HihPRdKbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=suptF6jWe6jhZcaE3wHg2zs8OP/TEFs7g8osLXMzyc/EemVQhxQyYmQYewyQ4zfeNIJT/SRZbFtn8CcLPEBBi1fsF4bPwBPl1sfD5oLGXll1sjZ71JY1LFoYn+aT/VSqxZNfHws1t+G4yFLcTQej56Dnes05x7v/E+fFSqGhhoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=JwWmsFrl; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b0c82eeso42606555e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 04:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1755602326; x=1756207126; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uFM57NTqp8aSor9WPLjNYqapZP2EKsyMGhaC6FPpLs8=;
        b=JwWmsFrlyi/5g8jinXwRqTbHWIwgROLgc+UgRAF6yOAkH5ZFHisSQdXV9Ri4Jmh8+N
         jEUIh0ZRBHMMRL4H62bsqpDg3XbPoMWmoDckGPYySrTb+Out+apd3VB+og6m4e6lixDu
         CLjwpBQY5wneH6XFnzMrzycwJX1dHAv1D+5Iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755602326; x=1756207126;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFM57NTqp8aSor9WPLjNYqapZP2EKsyMGhaC6FPpLs8=;
        b=L/GhVhNpeWp4J7Q5oxEs3ScdRfpqsOf2IuEXVRUF0OBLfixv3tp6okQkux04SE88ul
         nKBhbmsKHTPe5EGYkPQw9wd7Sq3lsbCbSR3xvBL6c0VffFoCy3wudv80TMjBGdvpZXyh
         2bW4j/nI7ICHqeP6frQWI4Ad+6N0lTsCrMuomkP3/Q1InZTDTwOMs4osRm+LsBdOqxCP
         Iash8ux2NmpITjEVenMHuJI60afZzrvuDiLrcbXcKTbWUGq2rQpnFJdaMOTOHU2bndiU
         nzDQoW821k2uFlmLPcmMEbh8SGlTJdsR/5RzC83f1Jf3u+kYZyGQzxe3oDZQa+EcVnX9
         1giA==
X-Forwarded-Encrypted: i=1; AJvYcCUI880sTgXv+YoxO7IkUHGp8y2eoGTdTCnETonUgU/HjPInTZW14ZOOkRJIzPk3W9qdVS8GF+j9YIewiWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWZhy6Et5d3El/I+QeBhSkiyK/JO1Y++Kjkcdnvp+DD7vpJcwc
	qRbOXNRnhEZx19w7MU9w2+LnXdQif5slDwP5ZKxUILKB/xEdq6nVxVN3W9QdfJVB9R8=
X-Gm-Gg: ASbGncuHjKIPoaAHU2z3r782uBP+jAteaz5rscUQecfrIsEQDo5qvgQCXoYwC1fRFH4
	zOpi6bQAtOiDk9/BBji5xGXfhIWSBAT9btH3ZdJDxChjSebPEcGa8N3y8GNz+uT0ETkZrjQi7Hk
	7648Iki1X+p2BtNbDTIfMOqGiGEQj42t4RyTQZq/PD5CfDwlCXsgLQeaiMBBGj6uGZlYO08YxuD
	s9uuqdpVj5uhiNMBtz+tRttaZrR2xTfR3/1hdqq4UiW6L+SHwwnOvTQ5d3IGFsyBCwwQCnUgiUo
	7j38wJLTeozHqgIql7S0ZS1pQN7roy7m3UYz/PNYVe156QpffAFLddNEn1HCQiOVwd5yJAlZaXm
	tYwRR08huW7ZytdCU9djKYOVOZLJunoh/YAqe5YtJs69Fwo/e9Oi2yT1DHgbW5m0PicIR
X-Google-Smtp-Source: AGHT+IFIlULbDAZ/EiOoYMhOj7ttjZb1va/Ls6LMpDap/PGCtOOka0Op0NaY3JlIquMGWnbWmrR7JQ==
X-Received: by 2002:a05:600c:4fc4:b0:459:e20e:be2f with SMTP id 5b1f17b1804b1-45b43dbc059mr14486535e9.14.1755602326545;
        Tue, 19 Aug 2025 04:18:46 -0700 (PDT)
Received: from [192.168.1.183] (host-195-149-20-212.as13285.net. [195.149.20.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b42a771ecsm37503735e9.9.2025.08.19.04.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 04:18:46 -0700 (PDT)
Message-ID: <0bfc7329-e13b-4781-a331-9f8898110b5f@citrix.com>
Date: Tue, 19 Aug 2025 12:18:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/microcode/intel: Refresh the revisions that
 determine old_microcode
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Sohil Mehta <sohil.mehta@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, Nikolay Borisov <nik.borisov@suse.com>,
 Alex Murray <alex.murray@canonical.com>, linux-kernel@vger.kernel.org,
 stable@kernel.org
References: <20250818190137.3525414-1-sohil.mehta@intel.com>
 <20250818190137.3525414-2-sohil.mehta@intel.com>
 <20250819051940.sqdjdvwupvocuf7w@desk>
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
In-Reply-To: <20250819051940.sqdjdvwupvocuf7w@desk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/08/2025 6:19 am, Pawan Gupta wrote:
> On Mon, Aug 18, 2025 at 12:01:36PM -0700, Sohil Mehta wrote:
>> Update the minimum expected revisions of Intel microcode based on the
>> microcode-20250512 (May 2025) release.
>>
>> Cc: <stable@kernel.org> # v6.15+
>> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
>> ---
>>  .../kernel/cpu/microcode/intel-ucode-defs.h   | 86 +++++++++++--------
>>  1 file changed, 48 insertions(+), 38 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/microcode/intel-ucode-defs.h b/arch/x86/kernel/cpu/microcode/intel-ucode-defs.h
>> index cb6e601701ab..2d48e6593540 100644
>> --- a/arch/x86/kernel/cpu/microcode/intel-ucode-defs.h
>> +++ b/arch/x86/kernel/cpu/microcode/intel-ucode-defs.h
>> @@ -67,9 +67,8 @@
>>  { .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0008, .driver_data = 0x1000191 },
>>  { .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0010, .driver_data = 0x2007006 },
>>  { .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0020, .driver_data = 0x3000010 },
>> -{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0040, .driver_data = 0x4003605 },
> ".model = 0x55, .steppings = 0x0040" is being removed? Total number of
> entries in the table are being reduced by ~10.

That's because early in a CPUs lifecycle, microcode for the late
pre-production steppings are still included in the public repo, but
eventually dropped.

Alas, these deletions are documented as well as everything else is in
the changelog...

~Andrew

