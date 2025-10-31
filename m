Return-Path: <linux-kernel+bounces-879846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCFBC243AA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6445E566170
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D79132E6B8;
	Fri, 31 Oct 2025 09:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8XbXsB4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF8F32E13F
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903520; cv=none; b=S95U+uO1K9KlRLJiJSTXGHLBvO4ChOjo8CNGQJQCRiW9MwrwEboVCBQnWYXdIL1EnXYqm2uv3s49u7b8ExqsstCMc2ra9ZIg+96gEdDC7+QOrWNjeQk6P5BYeSr8PlCK53eWWGPLtPSCY4YzJS6ih/IwMHNhx2O1GXoPMTK610c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903520; c=relaxed/simple;
	bh=Nt5I0/ypLAT6txRroayncaZ3u/sU4Zqs7ILdnZSNoEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S3R1BLMzsnK4fgluEmoeV+paZrd2LAaAU5agXPDCaQrnLPc1JW4bTLOfcsPg5A0L9esVx19yNQkj6HZBIEAu2yDtbR2VY+9puxt32jftPiKCl42qb61e5AjUivKN6Fx4h/7SD7XmCwuqjKGvqLFBSrBdqz3mtrQpgEA3zqqoNeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T8XbXsB4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761903517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=02r2jL8NwGKv+xoSmKl2Ton2WOVDTKsUsxJgoMdlPDY=;
	b=T8XbXsB4yzmfj/XLfRK5yQsKfTvBbN42UMLaqmepOQXtFPS0KsnZikFzqnbFyDXwOvEdu2
	wXxFYDrX/3ZSNV9VJ9rCXF53SJJznorbASR1ZDO2UMyHXZOlFuA5PDoK8qb6k5HM4XSPHc
	TnWjM05VNTDfDE7Pfwb4rK7dWNglIso=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-nJDA5n9BN4SvVdogBqk95A-1; Fri, 31 Oct 2025 05:38:36 -0400
X-MC-Unique: nJDA5n9BN4SvVdogBqk95A-1
X-Mimecast-MFC-AGG-ID: nJDA5n9BN4SvVdogBqk95A_1761903515
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4770c37331fso13483485e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:38:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761903515; x=1762508315;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=02r2jL8NwGKv+xoSmKl2Ton2WOVDTKsUsxJgoMdlPDY=;
        b=CxEcWGBpE7UTVBuCPlFji4Mjlh5ZL/c3r52wBLJWNZ6sMQSJg/aOWusgBgP2d1YKWb
         GA8QMfaU3brg4PUe8HtmKDz3mULYzZSllg04cI+ycjTnC6XvdC/Uzm1fAqeLvxroMZOr
         IIc2GxR1gDYCvX8phbG7cG8ZISY7RL4NKvQhdvVS2l/EBA4lrzsTQH/Gw0FgzHfwMQko
         99je8PapKudbGBwh6yhP46iOsL164dwSvJWJCXnDecOnpZowHW6cs/paSyE1LnnzAwZ3
         MOChFqHMaytF/LrDJJarCGR8Xa/lUIVnqIy1wJOZL/WV5wJElIWUDGNIrgDt/iRmm42n
         TWVg==
X-Gm-Message-State: AOJu0YznTC8iyTLW5ZQGsApz+q7RXZYWyTwghK/LT6KBOjEz1Z+3QCDF
	wt/NtwYUw1dL0w4FCF76iU/xLVWOjjSCCiuCsSaO33YjVN6m99GtSrY7b9P9d2H8zYPu6OHpebr
	VTckBG6KbEWFyJ2MS0DG5Zl+ebnw1YCh9OFbFK15QnwNjECno0113gZtSCohpY8XcHg==
X-Gm-Gg: ASbGncvBHPKJvQsMo3pq/9ZEt6qxTeHsaSMd8VwKjbfxozOm0iVzY/fcStxv51uKrmy
	9v/PCkSVT7AfBgKWiYPTIs/bId6fjkXPd41ltikYkliVT/EFHhloVkXl7zd4cAWww2RLhTAJVMs
	LD6d7PnGR1N/id2CoS0Vi324zANyIImU1DhYphKPe4ZIkWYwcdP/Fwob/WgiGnuoKh8oJBrII64
	4LmqWks2fALA01yF8DadtCjEmniPTsgbpa3lbtDcuS2eIU7kO5CKw/4hQCIcqeNjrF9+Zj1hjXO
	XmNY5LPIeivzYCs/830Jl9DJdlrhDH2cfwUZBsCdwI3HeGR7QYvO49XsemKlaxBzx+EjYrwUdnm
	NaNiuYlmAtCqJQQZLyvUFm9O6KKK8VfEnAn2goag46LOPf0GlSejOucyG1doVXfHwWrXR9Kh3Jb
	mXRTFZ
X-Received: by 2002:a05:600c:524e:b0:475:dd8d:2f52 with SMTP id 5b1f17b1804b1-4773089c6a2mr27897815e9.32.1761903515181;
        Fri, 31 Oct 2025 02:38:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKPPNsgtJzmw5biUQ5ItO9u/Z3xCbDPnnFiEadpPd1z4+pOhQMAMTMoHdglYjmo4QMI4f3Tg==
X-Received: by 2002:a05:600c:524e:b0:475:dd8d:2f52 with SMTP id 5b1f17b1804b1-4773089c6a2mr27897375e9.32.1761903514741;
        Fri, 31 Oct 2025 02:38:34 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.110.222])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-429c114be36sm2661136f8f.18.2025.10.31.02.38.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 02:38:34 -0700 (PDT)
Message-ID: <288ba4d2-b7db-46cf-b979-341a58613fc0@redhat.com>
Date: Fri, 31 Oct 2025 10:38:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] rust: lock: Export Guard::do_unlocked()
To: Alice Ryhl <aliceryhl@google.com>, Lyude Paul <lyude@redhat.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Benno Lossin <lossin@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
References: <20251029183538.226257-1-lyude@redhat.com>
 <c1ff48ea-53ca-40ea-9541-85abd1a528d0@redhat.com>
 <e0112480a6786c64fa65888b5ce8befbba72a230.camel@redhat.com>
 <CAH5fLgiWceOs-VtDnFkx5EBxCbAnJ3cLkRwp9adQC7x9oJCDFQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0j
 UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT7CwU0EEwECACMFAlRCcBICGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRB+FRAMzTZpsbceDp9IIN6BIA0Ol7MoB15E
 11kRz/ewzryFY54tQlMnd4xxfH8MTQ/mm9I482YoSwPMdcWFAKnUX6Yo30tbLiNB8hzaHeRj
 jx12K+ptqYbg+cevgOtbLAlL9kNgLLcsGqC2829jBCUTVeMSZDrzS97ole/YEez2qFpPnTV0
 VrRWClWVfYh+JfzpXmgyhbkuwUxNFk421s4Ajp3d8nPPFUGgBG5HOxzkAm7xb1cjAuJ+oi/K
 CHfkuN+fLZl/u3E/fw7vvOESApLU5o0icVXeakfSz0LsygEnekDbxPnE5af/9FEkXJD5EoYG
 SEahaEtgNrR4qsyxyAGYgZlS70vkSSYJ+iT2rrwEiDlo31MzRo6Ba2FfHBSJ7lcYdPT7bbk9
 AO3hlNMhNdUhoQv7M5HsnqZ6unvSHOKmReNaS9egAGdRN0/GPDWr9wroyJ65ZNQsHl9nXBqE
 AukZNr5oJO5vxrYiAuuTSd6UI/xFkjtkzltG3mw5ao2bBpk/V/YuePrJsnPFHG7NhizrxttB
 nTuOSCMo45pfHQ+XYd5K1+Cv/NzZFNWscm5htJ0HznY+oOsZvHTyGz3v91pn51dkRYN0otqr
 bQ4tlFFuVjArBZcapSIe6NV8C4cEiSTOwE0EVEJx7gEIAMeHcVzuv2bp9HlWDp6+RkZe+vtl
 KwAHplb/WH59j2wyG8V6i33+6MlSSJMOFnYUCCL77bucx9uImI5nX24PIlqT+zasVEEVGSRF
 m8dgkcJDB7Tps0IkNrUi4yof3B3shR+vMY3i3Ip0e41zKx0CvlAhMOo6otaHmcxr35sWq1Jk
 tLkbn3wG+fPQCVudJJECvVQ//UAthSSEklA50QtD2sBkmQ14ZryEyTHQ+E42K3j2IUmOLriF
 dNr9NvE1QGmGyIcbw2NIVEBOK/GWxkS5+dmxM2iD4Jdaf2nSn3jlHjEXoPwpMs0KZsgdU0pP
 JQzMUMwmB1wM8JxovFlPYrhNT9MAEQEAAcLBMwQYAQIACQUCVEJx7gIbDAAKCRB+FRAMzTZp
 sadRDqCctLmYICZu4GSnie4lKXl+HqlLanpVMOoFNnWs9oRP47MbE2wv8OaYh5pNR9VVgyhD
 OG0AU7oidG36OeUlrFDTfnPYYSF/mPCxHttosyt8O5kabxnIPv2URuAxDByz+iVbL+RjKaGM
 GDph56ZTswlx75nZVtIukqzLAQ5fa8OALSGum0cFi4ptZUOhDNz1onz61klD6z3MODi0sBZN
 Aj6guB2L/+2ZwElZEeRBERRd/uommlYuToAXfNRdUwrwl9gRMiA0WSyTb190zneRRDfpSK5d
 usXnM/O+kr3Dm+Ui+UioPf6wgbn3T0o6I5BhVhs4h4hWmIW7iNhPjX1iybXfmb1gAFfjtHfL
 xRUr64svXpyfJMScIQtBAm0ihWPltXkyITA92ngCmPdHa6M1hMh4RDX+Jf1fiWubzp1voAg0
 JBrdmNZSQDz0iKmSrx8xkoXYfA3bgtFN8WJH2xgFL28XnqY4M6dLhJwV3z08tPSRqYFm4NMP
 dRsn0/7oymhneL8RthIvjDDQ5ktUjMe8LtHr70OZE/TT88qvEdhiIVUogHdo4qBrk41+gGQh
 b906Dudw5YhTJFU3nC6bbF2nrLlB4C/XSiH76ZvqzV0Z/cAMBo5NF/w=
In-Reply-To: <CAH5fLgiWceOs-VtDnFkx5EBxCbAnJ3cLkRwp9adQC7x9oJCDFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/25 10:31, Alice Ryhl wrote:
> I do agree that this behavior has a lot of potential to surprise
> users, but I don't think it's incorrect per se. It was done
> intentionally for Condvar, and it's not unsound. Just surprising.

Yes, I agree that it is not unsound.`

For conditional variables, wait() is clearly going to release the mutex 
to wait for someone else so the surprise factor is much less.  Having it 
return a new guard would be closer to std::sync::Condvar::wait, but it'd 
add churn and I'm not sure how much you all care about consistency with 
std.  std has the extra constraint of poisoned locks so it doesn't 
really have a choice.

Paolo

> Of course, that doesn't mean we can't change it. Condvar could be
> updated to use ownership in that way, and doing say may be a good
> idea.


