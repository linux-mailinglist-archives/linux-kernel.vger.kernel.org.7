Return-Path: <linux-kernel+bounces-594318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCA4A81029
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 17:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D138C10FA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 15:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0E31E98ED;
	Tue,  8 Apr 2025 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w75jfA9i"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C8F185935
	for <linux-kernel@vger.kernel.org>; Tue,  8 Apr 2025 15:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744126129; cv=none; b=LFcxeRdOD0tPcY+2oRV4S7hET+7Pd+c6qOCIpSwqZPfUkciWhuLknblt5/pwEWSG7sIIQlFsNG4kOhKI5uiMOS+GM62F/gf6A9Nm8hf61LCVwKxsMUYgjkmjHln0iXKL7ATQKeSKBgRw7gVxtKvyJzg99U3Ts8deaSkUjE25BW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744126129; c=relaxed/simple;
	bh=15TAq4+0JCu/vVtFiEew5ZcEiWU9dLv8HKuLeuSlAkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uSLhBmSJv9SJjnHd7ygLmsM52FGI/J2l76Fm3uzD9UCn5fVPOfvtx2ZWjXfL6A5ztMPmWD/e6kR30YBvRDDCpLCPxQq5Z1t8uBZ9oYx/ksSnwBnaf/9G+/WFa1MNoiwIWIrVjspdX701NK0x+s/IW/kZUpeew6hT5ctEhE2b/0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w75jfA9i; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2d674a0e-9a54-4315-bd81-0cb3a2fb1602@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744126125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2UmQzvgk97m5bud5ShHuuzMTFoqRrCLfyIbWy1LiIbw=;
	b=w75jfA9io+TTp7OGZgBNEsJ9Im/D0seD8CVNr8YGxBlynMven66c/15jXpnVF4TU7bYgqw
	5bRn0odCPaOD+3pVjzmrTojpZLf9ycApVg46pA9LO8UpCo1cLbKqgsAi8P+PRj9NX+wHyD
	wY08dFo7amEjmcJFtWYkuC9IlWhLnPM=
Date: Tue, 8 Apr 2025 11:28:40 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] device property: Add
 fwnode_property_get_reference_optional_args
To: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Len Brown <lenb@kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>, linux-kernel@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>, linux-acpi@vger.kernel.org
References: <20250407223714.2287202-1-sean.anderson@linux.dev>
 <20250407223714.2287202-3-sean.anderson@linux.dev>
 <CAL_JsqLQvyBvOXJJhRcnVAVx81MUf9YwtyZ5VC-whwY=uoeDXw@mail.gmail.com>
 <52d79db7-f1fa-4695-aeb6-d07d6c2f90dc@linux.dev>
 <CAL_JsqJ_EqsxrY67OPm+t6tU5ikFA-TZ-fFqHPYQMuy16c_kLg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <CAL_JsqJ_EqsxrY67OPm+t6tU5ikFA-TZ-fFqHPYQMuy16c_kLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 4/8/25 11:19, Rob Herring wrote:
> On Tue, Apr 8, 2025 at 10:12 AM Sean Anderson <sean.anderson@linux.dev> wrote:
>>
>> On 4/8/25 09:00, Rob Herring wrote:
>> > On Mon, Apr 7, 2025 at 5:37 PM Sean Anderson <sean.anderson@linux.dev> wrote:
>> >>
>> >> Add a fwnode variant of of_parse_phandle_with_optional_args to allow
>> >> nargs_prop to be absent from the referenced node. This improves
>> >> compatibility for references where the devicetree might not always have
>> >> nargs_prop.
>> >
>> > Can't we just make fwnode_property_get_reference_args() handle this
>> > case? Or why is it not just a 1 line wrapper function?
>>
>> fwnode_property_get_reference_args ignores nargs when nargs_prop is
>> non-NULL. So all the existing callers just pass 0 to nargs. Rather than
>> convert them, I chose to add another function with different defaults.
>> There are only four callers that pass nargs_prop, so I could just as
>> easily change the callers instead.
> 
> Why do you have to change the callers? nargs value won't matter
> because they obviously have nargs_prop present or they would not have
> worked in the first place. If behavior changes because there's an
> error in their DT, who cares. That's their problem for not validating
> the DT.

Because the change would be to make nargs matter even when nargs_prop is
present. For the sake of example, consider something like

  foo: foo {
    #my-cells = <1>;
  };
  
  bar: bar {
  };

  baz {
    my-prop = <&bar>, <&foo 5>, ;
    my-prop-names = "bar", "foo";
  };

Before we would have

fwnode_property_get_reference_args(baz, "my-prop", NULL, 0, "bar", args) <bar>
fwnode_property_get_reference_args(baz, "my-prop", NULL, 0, "foo", args) <foo>
fwnode_property_get_reference_args(baz, "my-prop", "#my-cells", -1, "bar", args) ERROR
fwnode_property_get_reference_args(baz, "my-prop", "#my-cells", -1, "foo", args) ERROR
fwnode_property_get_reference_args(baz, "my-prop", "#my-cells", 0, "bar", args) ERROR
fwnode_property_get_reference_args(baz, "my-prop", "#my-cells", 0, "foo", args) ERROR

and after we would have

fwnode_property_get_reference_args(baz, "my-prop", NULL, 0, "bar", args) <bar>
fwnode_property_get_reference_args(baz, "my-prop", NULL, 0, "foo", args) <foo>
fwnode_property_get_reference_args(baz, "my-prop", "#my-cells", -1, "bar", args) ERROR
fwnode_property_get_reference_args(baz, "my-prop", "#my-cells", -1, "foo", args) ERROR
fwnode_property_get_reference_args(baz, "my-prop", "#my-cells", 0, "bar", args) <bar>
fwnode_property_get_reference_args(baz, "my-prop", "#my-cells", 0, "foo", args) <foo 5>

The problem is that all existing callers pass nargs=0 when
nargs_prop="#my-cells" so they will get the new behavior even when they
shouldn't. So if we change the behavior we have to change the callers
too. If we make a new function with new behavior the callers stay the
same.

--Sean

