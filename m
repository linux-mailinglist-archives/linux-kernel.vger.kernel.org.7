Return-Path: <linux-kernel+bounces-836371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C0EBA981D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E75C3B5E23
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449473090CE;
	Mon, 29 Sep 2025 14:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=elijahs.space header.i=@elijahs.space header.b="ZBNhyTNk";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="DzMH1a8p"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C7B3064BB
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 14:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759155139; cv=none; b=YBdwOCXHBtbJj9zQdn/bWXtyI32jZMhvUmVUcKkT2QEu81WMwQDKdQqg/tbSSH3Fw7Li6tMGM2EgwhWdRXSYdyW06RkeJ4rLvhVso+tnB3aRCZlcQnDHmmGcLRbjLpAFaO8qiXMhPlAuq6xWedESu1XDZUhcdn2T+DT7N1o7OR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759155139; c=relaxed/simple;
	bh=oPuZYF/E5DhWp+sFZmQbp9zye2zGWxCQpyMYGTjp80o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Gg12fCA7vMBuP+aocfdn+iIAgGbLZGOe9Su1eUfMn5syX4IgcZPDlpY/QsinmLC/nXgImvvmop0fDGlYjyvf+7vjspW/W4rCbn79RO/NRa4mRsNB8gfGhaoSAyEUHzTTRNKDpSfhu4CvSHJcYfDghxRc9b9KK/SxCIpuU/XSMjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=elijahs.space; spf=pass smtp.mailfrom=elijahs.space; dkim=pass (2048-bit key) header.d=elijahs.space header.i=@elijahs.space header.b=ZBNhyTNk; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=DzMH1a8p; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=elijahs.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elijahs.space
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=ZBNhyTNkuQMTegPV7L9ZxWlmdqbNIbmsbP509jKVcEC4f6WQLi1bUfZ86iQ1DLmPDO4GH+5Ix4ut3bqnQUrLtbqPb979pfp+h0GJ42ltT9YhFz9qppYvL2tMJs1C3VzTdsplFVzMoaxHBmNS0aChvwYlcoWXizR9yAIXbPezsdUIuwAdG3GAhpO4R14Ex7tafSOJW/Ga7SD7uo9JMOQ1otw1ApYN0DqwxplZSB3dys/WDFMi3/aKnES6tr7WAsrRxz++gUzA1KL1NbLKCHXH8O0HtCnGiL6D5Raat16dH48Usk04oAVM1upMBCFj/369iEj/U4ukOIoKxD16ysZg1Q==; s=purelymail2; d=elijahs.space; v=1; bh=oPuZYF/E5DhWp+sFZmQbp9zye2zGWxCQpyMYGTjp80o=; h=Received:Date:From:Subject:To;
DKIM-Signature: a=rsa-sha256; b=DzMH1a8pbkVGIJmZgQzHmD+W6VUh3NiLYZ/TfIE2zxrr8+MEH8dioIoJfCywn8fIhmRP8nArhafZd7v7imSDZuDbRkokQfx8bQfQx2C+W32k0bFrWTcsf7z9QMQ6FlQCFSJu6myx8wiWrhEIiDeUhy/WfhYdiLycZQ1b6v0u3mGRcSxZ6IrSWSxIUFOCYAqC9ZgkiyvLdEfFebXzrlpxGEnBKbZ9JcC3NcBIUj+LTNmwli5Cy9ugNonPswOAHOXkhYoY94etT9fbTQW5jIDeAh29ad+eyZJbXFm85WUh+SUewdQtWzC8JdDge33Qn0LJ8uHgVFq/fJ8XV5O3wPYR4Q==; s=purelymail2; d=purelymail.com; v=1; bh=oPuZYF/E5DhWp+sFZmQbp9zye2zGWxCQpyMYGTjp80o=; h=Feedback-ID:Received:Date:From:Subject:To;
Feedback-ID: 26912:4866:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1169688956;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 29 Sep 2025 14:11:37 +0000 (UTC)
Message-ID: <f6b874f7-0031-4a7e-b781-f888249f25af@elijahs.space>
Date: Mon, 29 Sep 2025 07:11:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Elijah <me@elijahs.space>
Subject: Re: [PATCH] rust: slab: add basic slab module
To: Danilo Krummrich <dakr@kernel.org>, Elijah Wright <git@elijahs.space>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>,
 linux-mm@kvack.org
References: <20250924193643.4001-1-git@elijahs.space>
 <DD1SGLU4180C.361W5XLH76XNC@kernel.org>
 <DD4IKU7O94WN.2VALE9M80XGQ7@kernel.org>
Content-Language: en-US
In-Reply-To: <DD4IKU7O94WN.2VALE9M80XGQ7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/28/2025 7:47 AM, Danilo Krummrich wrote:
> On Thu Sep 25, 2025 at 11:54 AM CEST, Danilo Krummrich wrote:
>>    (3) Implement a macro to generate a custom KmemCache Allocator trait
>>        implementation for every KmemCache instance with a static lifetime.
> 
> Thinking about it a bit more, I think we should go with option (3) for now.

do you want me to implement that now? if so I can take a look in a few hours

