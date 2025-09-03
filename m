Return-Path: <linux-kernel+bounces-798989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B3AB42594
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89C083A4CC6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6070267AF6;
	Wed,  3 Sep 2025 15:32:32 +0000 (UTC)
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CAC239562
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756913552; cv=none; b=cUBc48haH0jMoNNe7BMiU4JgiludiCnwYIw/gYmH+wJe4AZlqkUYA7aMZCpYVQNsBCyy5AsKq0FYHLG67BNpM/BkGCQOxZR6rJXBQzhGwZEyXiLi4WLxQ65cWYZM7G6s8MnBIT7KA7s565QX31vVguUj7ztFW7tZSSZNLoShypw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756913552; c=relaxed/simple;
	bh=cHBQ8j6RxUC9Ms6/bHBFv1Ch4/EE2YLkhPSpWOTu/Ro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qz9pOTEfaKDIiD2bVmt1JZQAiXRCy7rxGySPmjZLD2D61nkuTrWc0Gdb0vyW9ncVHKc5s1IU2QcAxThtY3KE9xlJ6QTn0/Skz09Z9wsOLi70ZZvv+X2NwQVxwzERQarG8wOVz35kFNRck3YCJfBdYQOik2zPODcXxrKr1yOBwJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=carnegierobotics.com; spf=pass smtp.mailfrom=douglass.dev; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=carnegierobotics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=douglass.dev
Feedback-ID: 3578:1022:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -360649041;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 03 Sep 2025 15:31:50 +0000 (UTC)
From: Woodrow Douglass <wdouglass@carnegierobotics.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Woodrow Douglass <wdouglass@carnegierobotics.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 0/2] regulator: pf530x: NXP PF530x regulator driver
Date: Wed,  3 Sep 2025 11:31:36 -0400
Message-Id: <20250902-pf530x-v3-0-4242e7687761@carnegierobotics.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250902-pf530x-v2-0-f105eb073cb1@carnegierobotics.com>
References: <20250902-pf530x-v2-0-f105eb073cb1@carnegierobotics.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10306; i=wdouglass@carnegierobotics.com; h=from:subject:message-id; bh=cHBQ8j6RxUC9Ms6/bHBFv1Ch4/EE2YLkhPSpWOTu/Ro=; b=owEBbQGS/pANAwAKAewLuLlPNh4UAcsmYgBouF1WMr8aaHwci3yi+f39tl9JXpr94miUUKVaO pTbVsoAQCiJATMEAAEKAB0WIQSIUqjrbDLQw0mgxHLsC7i5TzYeFAUCaLhdVgAKCRDsC7i5TzYe FPoqB/9Wizw/HyOyX64gNzv+o+QcZl3W0qOyqyP0Y1ga0q6NuupaK4xTsk4Mib5xP35FFzS+Mcu Xfe8qNqUv4atpiwLdU2UddSocfmQbrxF2ajad68Xg+7fkZUvber2XMX7R5Wvcl7q0BMWMs46gEg iWmkcPjTupM+5+1qNkJmIbojDxNfbU+LKqGkfpGODwdThobwBUdh/dWn51Q1T4X9QSHjX72X+zn LaTXTWwl5PB9shyJeW3Vu9HYd6IXiy5S8/2N6FK3zZvKrOu4voEaE9EGrMMInSn+ySw7Y/52qc0 fr7rBLqd31LD7JPIqWMCATmGZM3awmiejvkphn2l4YaGQuvk
X-Developer-Key: i=wdouglass@carnegierobotics.com; a=openpgp; fpr=8852A8EB6C32D0C349A0C472EC0BB8B94F361E14
Content-Transfer-Encoding: 8bit

All,

Sorry for resubmitting the original patches, i thought that's what was
wanted. I'm trying very hard not to break ettiquite here. Below are
some responses to your earlier comments. Thank you.

On 9/2/25 11:08, Mark Brown wrote:
> On Tue, Sep 02, 2025 at 10:21:33AM -0400, Woodrow Douglass wrote:
> 
>>  obj-$(CONFIG_REGULATOR_PALMAS) += palmas-regulator.o
>>  obj-$(CONFIG_REGULATOR_PCA9450) += pca9450-regulator.o
>>  obj-$(CONFIG_REGULATOR_PF9453) += pf9453-regulator.o
>> +obj-$(CONFIG_REGULATOR_PF530X) += pf530x-regulator.o
>>  obj-$(CONFIG_REGULATOR_PF8X00) += pf8x00-regulator.o
>>  obj-$(CONFIG_REGULATOR_PFUZE100) += pfuze100-regulator.o
>>  obj-$(CONFIG_REGULATOR_PV88060) += pv88060-regulator.o
> 
> I'd say please keep this sorted but there's some cleanup needed here
> already so whatever, let's deal with that separately.
> 
>> +static const struct regmap_config pf530x_regmap_config = {
>> +       .reg_bits = 8,
>> +       .val_bits = 8,
>> +       .max_register = PF530X_OTP_MODE,
>> +       .cache_type = REGCACHE_RBTREE,
>> +};
> 
> In general it's better to use _MAPLE register caches unless you've got a
> good reason not to, the data structure is more modern.
> 
>> +static int pf530x_is_enabled(struct regulator_dev *rdev)
>> +{
>> +	//first get mode
> 
> Usual comment style would have a space after the //.
>

this exact comment got lost in the fallout of the regmap changes below, but
i've fixed this issue elsewhere in the file, thanks.

>> +static int pf530x_get_status(struct regulator_dev *rdev)
>> +{
> 
> I would have expected this function to check INT_SENSE1/2 for current
> error statuses and report those.

I have added the INT_SENSE1 bits to the REGULATOR_STATUS_ERROR return value. I'm
not sure how to properly represent the thermal bits in INT_SENSE2 here -- this
part can safely run at high temperatures, some of those bits are just
informational in some designs (including the board I'm working on now)

> 
>> +static int pf530x_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
> 
> I see INT_STATUS2 has thermal warning/error interrupts in it as well.
> Not essential but it'd be nice to also check those.  These statuses are
> also clear on write so I'd expect a write to clear them, even though the
> device lacks an actual interrupt line so it's all somewhat ornamantal
> ATM :/  I suppse we ought to implement some core thing to do polling for
> non-interrupting regulators, but that's definitely out of scope for this
> driver.
> 
>> +static const struct regulator_ops pf530x_regulator_ops = {
>> +	.enable = regulator_enable_regmap,
>> +	.disable = regulator_disable_regmap,
>> +	.is_enabled = pf530x_is_enabled,
> 
> The custom is_enabled() operation doesn't seem to line up with the
> generic regmap enable/disable operations, and we don't seem to have
> enable_val or disable_val in the regulator_desc which the generic ops
> expect.  The whole connection with the modes seems a bit odd, the
> standby voltages look like they'd more naturally map to the regulator
> API's suspend mode but perhaps these devices are not usually integrated
> in that way and this would be controlled separately to system suspend.

I agree, I was misguided here. I've added enable_reg, enable_mask, enable_val,
and disable_val to the regulator_desc initializer, and moved to the regmap
function from helpers.c. I'm moving the "suspend mode" settings too here. The
board i'm working with has the suspend pin grounded, so I can't really test
suspend mode -- supporting that may have to wait for a future patchset.

> 
>> +static int pf530x_identify(struct pf530x_chip *chip)
>> +{
> 
>> +	dev_info(chip->dev, "%s Regulator found.\n", name);
> 
> It wouldn't hurt to read and log the data in REV, EMREV and PROG_ID too
> (it can be helpful when debugging).

I've added REV and PROG_ID, EMREV is listed as "Reserved for NXP Internal Use"
on page 95 of the datasheet, and  -- I can include those bits here but i'm not
sure they're very useful; if you'd like me to include those bits anyway i will

On 9/2/25 15:19, Krzysztof Kozlowski wrote:
> On 02/09/2025 16:21, Woodrow Douglass wrote:
>> Bindings for the pf530x series of voltage regulators
>>
>> Signed-off-by: Woodrow Douglass <wdouglass@carnegierobotics.com>
>> ---
>>  .../regulator/nxp,pf530x-regulator.yaml       | 74 +++++++++++++++++++
> 
> <form letter>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
> 
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline) or work on fork of kernel
> (don't, instead use mainline). Just use b4 and everything should be
> fine, although remember about `b4 prep --auto-to-cc` if you added new
> patches to the patchset.
> 
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time.
> 
> Please kindly resend and include all necessary To/Cc entries.
> </form letter>
> 
> 
>>  1 file changed, 74 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/regulator/nxp,pf530x-regulator.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/nxp,pf530x-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pf530x-regulator.yaml
>> new file mode 100644
>> index 000000000000..f1065b167491
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/regulator/nxp,pf530x-regulator.yaml
> 
> 
> Filename should match compatible, so nxp,pf5300.yaml.
> 
>> @@ -0,0 +1,74 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/regulator/nxp,pf530x-regulator.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: NXP PF5300/PF5301/PF5302 PMIC regulators
>> +
>> +maintainers:
>> +  - Woodrow Douglass <wdouglass@carnegierobotics.com>
>> +
>> +description: |
>> +  The PF5300, PF5301, and PF5302 integrate high-performance buck converters, 12 A, 8 A,
>> +  and 15 A, respectively, to power high-end automotive and industrial processors. With adaptive
>> +  voltage positioning and a high-bandwidth loop, they offer transient regulation to minimize capacitor
>> +  requirements.
> 
> Wrap according to Linux coding style.
> 
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - nxp,pf5300
>> +      - nxp,pf5301
>> +      - nxp,pf5302
> 
> Your driver clearly suggests these are compatible, so express it (see
> example schema).
>

I'm not sure I understand this comment. The difference in these parts is
only the current limit, so the software interface is compatible -- should I
only have a single "compatible" string (nxp,pf5300) and ignore the other
two variants? Seems like it would limit searchability for future users of
the driver, but maybe i'm not understanding what you're asking for here?
I was following nxp,pf8x00-regulator.yaml as an example (I am also using
that regulator in this design) and i guess it must be a bit dated.

>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  regulators:
> 
> No need for this node.
> 
>> +    type: object
>> +    description: |
>> +      list of regulators provided by this controller
>> +
>> +    properties:
>> +      SW1:
> 
> No need, drop the node.
> 
>> +        type: object
>> +        $ref: regulator.yaml#
>> +        description:
>> +          Properties for the regulator.
>> +
>> +        properties:
>> +          regulator-name:
>> +            pattern: "^SW1$"
> 
> No, drop entirely regulator-name. Just embed the properties in parent node.
> 
>> +            description:
>> +              Name of the single regulator
>> +
>> +    additionalProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - regulators
>> +

I have removed the regulators node (and refactored the driver to
not require it)

>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c1 {
> 
> i2c
> 
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        vddi_0_75@28 {
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> If you cannot find a name matching your device, please check in kernel
> sources for similar cases or you can grow the spec (via pull request to
> DT spec repo).
> 
> See also DTS coding style.
> 
>

I have updated this example to be more generic.

> 
> Best regards,
> Krzysztof
> 

Thanks again,
Woodrow Douglass

--
2.39.5

---
Changes in v3:
- Replaced REGCACHE_RBTREE with REGCACHE_MAPLE
- Replaced pf530x_is_enabled function with regulator_is_enabled_regmap
- Added status bits from INT_SENSE1 to pf530x_get_status function
- Added extra context to info print upon chip identification
- Reworked devtree to not require nested "regulators" subnode
- Some minor reformatting of comment style and long lines
- Link to v2: https://lore.kernel.org/r/20250902-pf530x-v2-0-f105eb073cb1@carnegierobotics.com

---
Woodrow Douglass (2):
      regulator: pf530x: Add a driver for the NXP PF5300 Regulator
      regulator: pf530x: dt-bindings: nxp,pf530x-regulator

 .../devicetree/bindings/regulator/nxp,pf5300.yaml  |  52 +++
 MAINTAINERS                                        |   6 +
 drivers/regulator/Kconfig                          |  12 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/pf530x-regulator.c               | 359 +++++++++++++++++++++
 5 files changed, 430 insertions(+)
---
base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
change-id: 20250902-pf530x-6db7b921120c

Best regards,
-- 
Woodrow Douglass <wdouglass@carnegierobotics.com>


