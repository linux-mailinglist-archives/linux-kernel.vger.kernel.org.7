Return-Path: <linux-kernel+bounces-799825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3095EB430AE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 05:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E5CF2015CD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 03:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42EB226CEB;
	Thu,  4 Sep 2025 03:55:33 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D58225765;
	Thu,  4 Sep 2025 03:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756958133; cv=none; b=iwEV+hACY41V8gmpqb3W6tX5HVakx1KA6vGQAsOfCQ9wESZrD/AGi2p+YWs35uXzjS5kr8z8jMA6eOLZP3xPMlU/pzz1vSKtL1zdH+9VqaRXPox2qan+lhuIxfA5lHasm24omw8TGFJ8SZmmP88IdbfsoxQOzXqLvLk3p7fglLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756958133; c=relaxed/simple;
	bh=QHOlv8hj4fETBStMEW8B0hy0C84QYz6c2LTvCjxqjO0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=B0ZiYwmTRmTv3TpD0fSfOv8v84JcuLc+02K7jctqsmWX12wdsyURPcwbkWx8vykRIrtYcW9DZ235jSmrrXv4h5HNkxzAm9B0HyGBcCZaU8ynY35l/ZHLT7xZTvg94pIPYP8P4U+qFkO7hm59TYa96aUKUr0PNgdOItgJao7/tA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Dx_7+yDbloc4EGAA--.13146S3;
	Thu, 04 Sep 2025 11:55:30 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxZOSxDbloHQZ9AA--.65383S3;
	Thu, 04 Sep 2025 11:55:30 +0800 (CST)
Subject: Re: [RFC PATCH 1/3] docs: rust: quick-start: Add another way to
 install
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Huacai Chen <chenhuacai@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 WANG Rui <wangrui@loongson.cn>, rust-for-linux@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250903095315.15057-1-yangtiezhu@loongson.cn>
 <20250903095315.15057-2-yangtiezhu@loongson.cn>
 <CANiq72m0HO91gFcVuH3kPz6b6fZ_vrbO3BGmb3DpyhuRnvGkeQ@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <4f8a98af-d5ec-faac-27bb-2d1b0ec7ed77@loongson.cn>
Date: Thu, 4 Sep 2025 11:55:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANiq72m0HO91gFcVuH3kPz6b6fZ_vrbO3BGmb3DpyhuRnvGkeQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxZOSxDbloHQZ9AA--.65383S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7XFW8Wr4fKr4fCFy7Xw47GFX_yoW3ArgEvr
	4Duwn5CrZ5ur4fZa1FgF4Y9ryfWa9YvrZ8tFWUWw47Ga4vqasxJFnY9FyfZF4jgw43WFnx
	GrZxZr12kFWfuosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
	oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F4
	0EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_
	Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbI
	xvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcsjjDUUU
	U

On 2025/9/3 下午6:11, Miguel Ojeda wrote:
> On Wed, Sep 3, 2025 at 11:53 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> It seems that the latest version of rustc is not compatible, in order to
> 
> This is only in nightly Rust -- we have a couple commits in -next that
> make Rust >= 1.91 work. Could you please try those? i.e. starting at
> 8851e27d2cb9 ("rust: support Rust >= 1.91.0 target spec"). They should
> land in e.g. -rc5.

OK, will try.

> Regarding `rustup`: we could link to the install instructions, but I
> don't think it is a good idea to replicate a particular `curl` line
> that could change upstream (e.g. the domain changing hands),
> especially one that installs something on the fly.

I will drop this patch in the next version.

Thanks,
Tiezhu


