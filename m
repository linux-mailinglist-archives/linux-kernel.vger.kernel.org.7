Return-Path: <linux-kernel+bounces-891845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0F7C43A4E
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 09:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D5B24E3F55
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 08:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6092C158F;
	Sun,  9 Nov 2025 08:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dG7ZNrc5"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEFD1482F2
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 08:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762677966; cv=none; b=mKib+isHH8c84NsFamP9Tf6NVNvhCB3q8s/lgDXpcD1nAZloZH6aUsJrdRgrzOV032AxabQqax6LPhPEVLCUw44kvuwOjK76tNouYajxBQllUKpFkETCYIMR9XnEvJDguQGUii6bl4Rapi4PfcOlcD9fZhq7P14JwHRbecO8B/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762677966; c=relaxed/simple;
	bh=54WQTc6lR8z81FA7ObDcQtg9c0u+LuwtW1fIgCF/2Ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M7xC4R+YzNKozUT1G+UxZ7XXk9O7VTegzZB9950yXDYhKvH3KdD5C4u2Oc8SbmcRj37EXvRmCZnf/QiHBeRRK5Zs4xY+k/ees96DX2YrGIJfg0ST6ekrd2IQSj6t/pB0QMHEHBVuDOHCxWE5Gu7UDuOddlx19jK0kHlDFoap09U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dG7ZNrc5; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-297ef378069so5931305ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 00:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762677964; x=1763282764; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o5T4uX1koGHDDgi89YiBEyrpTYE7hftNwgKTli6JfQw=;
        b=dG7ZNrc5JlyZsJYxDfh6vTwILgoFYwe+eCCigtN4BfBcNnt+8AZLiZDF8P2Jfi5t5v
         6JenJQBADTsYz4WqAwf9trVPrJkLit/iLXkOOrIdr90Nend3NG+tc3AGmutnXq6oTz1J
         DXd0OgXhjNQsklOMeEwCuePzkjg2c1MxW8T+HR/lw6VKSs+j8DQBOLuNW26k7K7MXDk6
         qfj3AY/oWratDMp/yQfUFHPKVEInXwHViJ1ztcH6//3DGrpH0jST5xg7vlE1tDUam4BP
         Y8MCkI2fdTgW5UyeGS4Eut45V3PvEn1i159X1wMZEAx8HT+QUuzKTerRvUHX6/kfPVxP
         ltOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762677964; x=1763282764;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o5T4uX1koGHDDgi89YiBEyrpTYE7hftNwgKTli6JfQw=;
        b=Ir+8dnkRZUZIbmJhTjXQPmm6GzDMlmb7sUKzEy2m6O04pztidzIFdTTmaGYJ4J0prE
         DSRrpQxrdpxANPFIWaqTuWGWdut5QJ3t9+icDu/BQnPEADJ42cXwg6y+18LNOn6RAaaH
         gqXArFsVGCbfXL/NXa7c6h4P2GWQvA0JODjdKHK/Dngrr+wuN2wJEDrqZUBfCvvwYzYw
         +gp52elRLXDLVjEKu6YgiEksISjqYb2WuXalcsPUK+wbciYa7BrNEoq/ieHT8GnXZldF
         pBx2LstImuZVLvASwJOEenvIxWFIgV41nOwJKqcyzyARIZPjYoTk+9qgSJNMNmcUXz43
         HFCw==
X-Forwarded-Encrypted: i=1; AJvYcCXrStpVNi5LKGP/35uptRvpE/jcwKX28ky38+/phCRiKuk1pa+hcRpydoW+0dLaWbMzTZvuVlEVYV9ZO+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6mQFo0WAoKTI2hrvnKZBBewfUVngM+HE1gamu+NYWJfRji5nu
	m8bHB8vdrA/MuFoEkKx2d5NakLP5dks7lD8ifTN28WPoRZWamGOJSkza
X-Gm-Gg: ASbGncsL2Y8k4DtJxlB6G0zhiUoWpx2eNoL0z7WUU+c/O/V54esdw9wVjGp65oKgDYI
	3mYF0ZPqCL6O6XfnB+W+OC7Xhgo+aRdf66taELDbmqcLK7EdvJRHlFTRCaSj2gfpaQq54/v+jHA
	Ecr5ANxLbxr8Ia4DklrmIl2zn4qTJEtoRDmjlYShS86z8CVq2JFgGjJMzy4ulXoivCAWPLJEUT7
	Y29sBuL+kwn4J25L48oU7t95X1OTsRHMTLz9zyIHmaC78VKF5jkj7zMlZM9HJhpkmPlgAW4pVJ8
	dLYHgPYh6obk4tG3CiuO6+DeRMfPJXa3bBh5U5JHuK0K145pzyaRHWrPL3EN+Go8oCap/B1GkmI
	DNKxHBtg0rGiij3zMrm61Y6/d6wH9enDR5uEYdPKdGyJZZ6uIDwvWqJWMG4qM5oMY6AlMfV5XiP
	ohfn/gdzIM7TF7qTWt6NhEdJ1SouWQGpgeSSZVt30FJ3jmSWZ6GPAv01gRFgSR8QMN3a9KscRJm
	7uRs3FOTUb+qLzC/D5UTGRmkKCYlyWEE0rvku5xWi3MZ+DcGsfdDN48Eorp2SKplvmp/f16Ig==
X-Google-Smtp-Source: AGHT+IFueiKLss2jbu9z7chio2oOhPrap0SY0ZUYTS417JmnaSAbbgJIMLKb0fJ0kOcrnR3sMzx+DQ==
X-Received: by 2002:a17:902:f601:b0:295:3584:1bbd with SMTP id d9443c01a7336-297e56ca193mr62556205ad.41.1762677964110;
        Sun, 09 Nov 2025 00:46:04 -0800 (PST)
Received: from ?IPV6:2402:e280:21d3:2:239e:6867:ce87:9df7? ([2402:e280:21d3:2:239e:6867:ce87:9df7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297e8d3f9easm39482385ad.106.2025.11.09.00.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 00:46:03 -0800 (PST)
Message-ID: <59ef14bb-0576-4660-8de1-be9cdd1a400d@gmail.com>
Date: Sun, 9 Nov 2025 14:15:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] iio: adc: Add support for TI ADS1120
To: David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org
Cc: jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251030163411.236672-1-ajithanandhan0406@gmail.com>
 <20251030163411.236672-3-ajithanandhan0406@gmail.com>
 <fd432bbf-f6c8-441a-882f-f8e52aaca0e9@baylibre.com>
 <a7532aa1-2acb-4064-b10c-b1f7022d589b@gmail.com>
 <de424e9d-95cd-4a42-8f1a-97ad04f5f9ef@baylibre.com>
Content-Language: en-US
From: Ajith Anandhan <ajithanandhan0406@gmail.com>
In-Reply-To: <de424e9d-95cd-4a42-8f1a-97ad04f5f9ef@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/7/25 9:48 PM, David Lechner wrote:
> On 11/7/25 9:50 AM, Ajith Anandhan wrote:
>> On 10/31/25 2:43 AM, David Lechner wrote:
>>> On 10/30/25 11:34 AM, Ajith Anandhan wrote:
>>>> Add driver for the Texas Instruments ADS1120, a precision 16-bit
>>>> analog-to-digital converter with an SPI interface.
>>>>
> One note about the review process. Any suggestions you agree with, you
> don't need to reply to specifically. You can trim out those parts in
> your reply. It saves time for those reading the replies.
>
>>>> +struct ads1120_state {
>>>> +    struct spi_device    *spi;
>>>> +    struct mutex        lock;
>>>> +    /*
>>>> +     * Used to correctly align data.
>>>> +     * Ensure natural alignment for potential future timestamp support.
>>>> +     */
>>>> +    u8 data[4] __aligned(IIO_DMA_MINALIGN);
>>>> +
>>>> +    u8 config[4];
>>>> +    int current_channel;
>>>> +    int gain;
>>> Since inputs are multiplexed, we can make this gain a per-channel value, no?
>> Yes we can, However i want  to keep the initial version simple so would it be
>>
>> fine to support per-channel gain configurationin upcoming patches?
> Absolutely. I really appreciate splitting things up like that as it makes
> it much easier to review.
>
>>> It also sounds like that certain mux input have to have the PGA bypassed
>>> which means they are limited to only 3 gain values. So these would have
>>> a different scale_available attribute.
>>   Since, I'm gonna enable all the 15 channels. I believe we have to have all
>>
>> gains(for differential channels). Correct me if i'm wrong.
> Yes, that is how I understood the datasheet. Differential channels have all
> gains. Single-ended channels and diagnostic channels only get the low gains
> (1, 2, 4).
>
>
>>>> +static int ads1120_write_reg(struct ads1120_state *st, u8 reg, u8 value)
>>>> +{
>>>> +    u8 buf[2];
>>>> +
>>>> +    if (reg > ADS1120_REG_CONFIG3)
>>>> +        return -EINVAL;
>>>> +
>>>> +    buf[0] = ADS1120_CMD_WREG | (reg << 2);
>>>> +    buf[1] = value;
>>>> +
>>>> +    return spi_write(st->spi, buf, 2);
>>>> +}
>>> Can we use the regmap framework instead of writing our own?
>> I’d like to keep the first version simple so i will add the regmap support in the
>>
>> later patch since the single ended has less spi transaction to handle.
> It would be less churn to implement the regmap right away. Typically
> we try to avoid churn if we can help it. So this would be an exception
> to the general suggestion that splitting things up is better.


Got it, I’ll add regmap support and address all review comments in the v2
patch series.

BR,

Ajith.


