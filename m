Return-Path: <linux-kernel+bounces-802154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A051B44E40
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30C01C226AC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FA52D2483;
	Fri,  5 Sep 2025 06:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JnMqhJtQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08891D9663
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 06:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757055029; cv=none; b=tXHd6DwOpOseKlmTWfAK5pH6jH2i9Me2ENCj/uQOBITesizxrZT7rr1npJ4wJI/zbr+3LXok4+VhzEdyTerLkOWU5ElR/ZJUVyS9LQmrcNbiAhVi5b4JeJmPfyz/TbYVxnpbdOFB7rdiTjlJ+T5wfFFU7zRFgYr9Vz+L6lxAtR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757055029; c=relaxed/simple;
	bh=Y3vaYaLxaSBtwlXphX5LeCK51R2e4El29Banad48jA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8pqkGlu9wOBVExMzSEh+PASS0MiFAGhqYXA1KHubsSlAS2T4n1hQRD5MrfN+LWf64anlLiBPnlvc0cf7znyl83K7XvLqsWtAo85dTDTAYKLTcwFGqBelwjDVcI7oZud/xCZwpez2UlJ+aHnmD6r5wXHphBKzfPHRemKjYr0f8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JnMqhJtQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757055026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PzkSnPUjwi+M04mIJFUTah0Llj9pDwzPR0FvY23x6pY=;
	b=JnMqhJtQwzxbbBIJyfCLL5sA2h4wPe2vyP3292fQqe1uiEU9TBy2/LvwTnrT8erhMDPZDA
	1jeXvzO7j93nrViAsoni0COCdkJWNE26DdqJF63kRSDweAiZXGCc+VoVxtANN2RBUkeVRT
	Kme3MDIcpnX8hVOfj9beFqmVX9ytWiw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-fN3M7AV3P9KsU3yFI72dPg-1; Fri,
 05 Sep 2025 02:50:14 -0400
X-MC-Unique: fN3M7AV3P9KsU3yFI72dPg-1
X-Mimecast-MFC-AGG-ID: fN3M7AV3P9KsU3yFI72dPg_1757055012
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 520EA19560AE;
	Fri,  5 Sep 2025 06:50:12 +0000 (UTC)
Received: from [10.45.224.74] (unknown [10.45.224.74])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0E6A9180044F;
	Fri,  5 Sep 2025 06:50:07 +0000 (UTC)
Message-ID: <bc39cdc9-c354-416d-896f-c2b3c3b64858@redhat.com>
Date: Fri, 5 Sep 2025 08:50:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] dt-bindings: dpll: Add per-channel Ethernet
 reference property
To: Rob Herring <robh@kernel.org>
Cc: netdev@vger.kernel.org, mschmidt@redhat.com, poros@redhat.com,
 Andrew Lunn <andrew@lunn.ch>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20250815144736.1438060-1-ivecera@redhat.com>
 <20250820211350.GA1072343-robh@kernel.org>
 <5e38e1b7-9589-49a9-8f26-3b186f54c7d5@redhat.com>
 <CAL_JsqKui29O_8xGBVx9T2e85Dy0onyAp4mGqChSuuwABOhDqA@mail.gmail.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <CAL_JsqKui29O_8xGBVx9T2e85Dy0onyAp4mGqChSuuwABOhDqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93



On 05. 09. 25 12:06 dop., Rob Herring wrote:
> On Fri, Aug 29, 2025 at 8:29 AM Ivan Vecera <ivecera@redhat.com> wrote:
>> ...
>>
>> Do you mean to add a property (e.g. dpll-channel or dpll-device) into
>> net/network-class.yaml ? If so, yes, it would be possible, and the way
>> I look at it now, it would probably be better. The DPLL driver can
>> enumerate all devices across the system that has this specific property
>> and check its value.
> 
> Yes. Or into ethernet-controller.yaml. Is a DPLL used with wifi,
> bluetooth, etc.?

AFAIK no... ethernet-controller makes sense.

>>
>> See the proposal below...
>>
>> Thanks,
>> Ivan
>>
>> ---
>>    Documentation/devicetree/bindings/dpll/dpll-device.yaml  | 6 ++++++
>>    Documentation/devicetree/bindings/net/network-class.yaml | 7 +++++++
>>    2 files changed, 13 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/dpll/dpll-device.yaml
>> b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
>> index fb8d7a9a3693f..560351df1bec3 100644
>> --- a/Documentation/devicetree/bindings/dpll/dpll-device.yaml
>> +++ b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
>> @@ -27,6 +27,12 @@ properties:
>>      "#size-cells":
>>        const: 0
>>
>> +  "#dpll-cells":
>> +    description: |
>> +      Number of cells in a dpll specifier. The cell specifies the index
>> +      of the channel within the DPLL device.
>> +    const: 1
> 
> If it is 1 for everyone, then you don't need a property for it. The
> question is whether it would need to vary. Perhaps some configuration
> flags/info might be needed? Connection type or frequency looking at
> the existing configuration setting?

Connection type maybe... What I am trying to do is define a relationship
between the network controller and the DPLL device, which together form
a single entity from a use-case perspective (e.g., Ethernet uses an
external DPLL device either to synchronize the recovered clock or to
provide a SyncE signal synchronized with an external 1PPS source).

Yesterday I was considering the implementation from the DPLL driver's
perspective and encountered a problem when the relation is defined from
the Ethernet controller's perspective. In that case, it would be
necessary to enumerate all devices that contain a “dpll” property whose
value references this DPLL device.

This approach seems quite complicated, as it would require searching
through all buses, all connected devices, and checking each fwnode for a
“dpll” property containing the given reference. I don’t think this would
be the right solution.

I then came across graph bindings and ACPI graph extensions, which are
widely used in the media and DRM subsystems to define relations between
devices. Would this be an appropriate way to define a binding between an
Ethernet controller and a DPLL device?

If so, what would such a binding roughly look like? I’m not very
experienced in this area, so I would appreciate any guidance.

If not, wouldn’t it be better to define the relation from the DPLL
device to the network controller, as originally proposed?

Thanks,
Ivan


