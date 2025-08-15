Return-Path: <linux-kernel+bounces-771267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE387B284DB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAAFC7AFAED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABECF5464F;
	Fri, 15 Aug 2025 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="iLEkY89z"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0392F9C3A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 17:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755278513; cv=none; b=c3q6Hr0PA7ajLV4RuT9MhsecbGy9nWWicw3XSe1fJhvi7KmNw+gko6NOIpslqKJIdtI7HxK5QjGPVDaMoeHgPykuJKx6oJd/HLkSQJtpn6esQvz86oKw8ihXMG7X+gOlRy12bJKStKuE98QNC5xYaIEqSekNXwjXX4fBwdl1kis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755278513; c=relaxed/simple;
	bh=4ZL0bRDd8O9uSHfWegdNoycSbwD4KpHOyXInfbC9h7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6mDItTq8hzTmnWVEnmBLzbx21KAmny24+IlUiCHGou9GQXWtAzHP1OyHgUoC0xYx8fe3iVqw72G0iX/oDqUTQwpgWJAtxZmTk+oIk+shqFRdgY/NIu1PBx+g1pHDDUNOkPfGyIzce3mRo0wqUA4dAhFKS7aJtY98/F3ASYNYEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=iLEkY89z; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a1b0cbbbaso14783925e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 10:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1755278510; x=1755883310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZL0bRDd8O9uSHfWegdNoycSbwD4KpHOyXInfbC9h7k=;
        b=iLEkY89ziLc+D0yfDM4njI5FxTsbqqteLb/msTh3o2JYS3ijlhuwzs1O8FMXVyKyDi
         ubmkawJRwPRwc7jXu1ZSqYEIvJxXfmeNMWSAkm5nu7XWEdDD8umuS4FW+aipCgCZ7KsD
         Ku3XVIk0Lk7E81FLcNyuW5rSd0WoQ2oJvexBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755278510; x=1755883310;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZL0bRDd8O9uSHfWegdNoycSbwD4KpHOyXInfbC9h7k=;
        b=MG/2z1XItLpuqzOoHO8brwlpmoOcj6K2HnxysNs4yWQ9w4ynpYZcURKXtZE2pB74W5
         1RubYOCjIkQOQlwcfU0S1+M2/1vLg3+G4jzeraWbqdFtthxgGqRYjvO+Q/ZJq/+w1SK+
         TzXL72iwQEBNpNn5BdtKFrNaY2HrjUNdD1+BtMuHeQ0R/bIZJmP3Xh7v04SUWwKuYvgb
         fLHC9toSHCT4IYDYETTXas1IU5+oj9VTuj+TEQg6XgY79lh276J4DGmTHYFEOzDttOYe
         BaT7te021gGibcAS55gjyAYEP5U0oDW0elEod3MQtRyiipec5Kmj+s1C6aFSPc/Lxz6J
         +kPA==
X-Forwarded-Encrypted: i=1; AJvYcCWivdS0pTljxlcogVpGsWMt7TmG1IEsPDVLSsUDnAo9gM9aNEbs75Sit4hxY2lXwxuNagk068AWqJ/RbnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YySY3xVp9lYCSUDd/RXiPQCyphsrGuJOPUP4Ehm5M/5EWVcuKFj
	ObFIc5rMM9VaA7OQdmbclasbDSEkQSnjyJRUNir8rm7EgrSN/d/4Wx9CgmLTK6hBXIM=
X-Gm-Gg: ASbGncv0VvzqSfdUNnzgorJyJzTfmn5hIfOoqWQtBtHN0TmFnfLEkKzR8Ap2CC7E+4q
	UTFixflzxmIBU46ZrBXRS8M+thYN/FaYCBKjFIrNXXOIGu08dM1ZMjyLf+Tj8RTF/BQcAaHjmNd
	pub2XAhN+LedfIxzVUCqwVQCgiYEfOWjPRvjEWPuPaggsLiz+4A0XcbT1ZYcRLr89KuKibXbrQy
	wH8jemg4L0WYSv7A+yaG6HDlrEmU6Hg2edw7GoAay0DlDEQbNMGiEJ4o3EtJ9CIYsvSxjNoyLSi
	iAkIPFI0ijZvC3ZMPibcI2JyuVPCOphxo9vQopCd6RCPeP7hCyeDLEtL/OXpdn4bKT8hqvUzAvX
	uD523HtFJdE0OWRVoH9bI+k7zWeIWtuXkw6zV27km1ipdxCU9lic0XQsCci03ajFBISor
X-Google-Smtp-Source: AGHT+IFLpF5jMiMYrRRBHdAiBCob7Fl8EGquPFWrJyKnNndR/zM6RtCW2pKmmcymsSU333i3DF1edQ==
X-Received: by 2002:a05:600c:19d3:b0:459:df25:b839 with SMTP id 5b1f17b1804b1-45a2186e2c2mr20864005e9.33.1755278509683;
        Fri, 15 Aug 2025 10:21:49 -0700 (PDT)
Received: from [192.168.1.183] (host-195-149-20-212.as13285.net. [195.149.20.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a21aa51cesm18029915e9.1.2025.08.15.10.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 10:21:49 -0700 (PDT)
Message-ID: <7594ecd7-994d-4cb8-9f8a-b6c1d4b01e17@citrix.com>
Date: Fri, 15 Aug 2025 18:21:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] x86,ibt: Use UDB instead of 0xEA
To: "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, kees@kernel.org, alyssa.milburn@intel.com,
 scott.d.constable@intel.com, joao@overdrivepizza.com,
 samitolvanen@google.com, nathan@kernel.org, alexei.starovoitov@gmail.com,
 mhiramat@kernel.org, ojeda@kernel.org, linux-kernel@vger.kernel.org
References: <20250814111732.GW4067720@noisy.programming.kicks-ass.net>
 <2c121572-8fde-4288-80ca-ab79f2b22cce@zytor.com>
 <20250815074939.GA3419281@noisy.programming.kicks-ass.net>
 <20250815102839.GD4068168@noisy.programming.kicks-ass.net>
 <20250815103055.GE4068168@noisy.programming.kicks-ass.net>
 <fc0715e0-42f2-4b5d-be31-ac44657afc56@citrix.com>
 <20250815105908.GB3245006@noisy.programming.kicks-ass.net>
 <055f4c2b-0e7f-44ae-92ff-a1025a217208@citrix.com>
 <78bd985a-a59e-4469-a84d-a0eb7faa20c3@zytor.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <78bd985a-a59e-4469-a84d-a0eb7faa20c3@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/08/2025 6:14 pm, H. Peter Anvin wrote:
> On 2025-08-15 04:19, Andrew Cooper wrote:
>>> CS Jcc, decodes to Jcc,pn for non-taken
>>> DS Jcc, decodes to Jcc,pt for taken
>> Ah, thanks.  I was looking at the hex in one of the comments and still
>> couldn't figure it out.
>>
>> So with this notation, we also have the dual meaning of ,pt between the
>> P4 and LNC.  At least the encoding is the same.
>>
> What "dual meaning?"

Well, it has different semantics now it's been reintroduced in LNC. 
(Only has any effect on a prediction miss, and causes a proactive decode
resteer).

Sure, it's "just perf" so can be argued as "compatible behaviour", but
people caring about the ,pt / ,pn properties do need to know the different.

~Andrew

