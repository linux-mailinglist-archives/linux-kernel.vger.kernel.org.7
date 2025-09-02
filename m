Return-Path: <linux-kernel+bounces-796925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C9EB4096E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A72457AF60A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DDD32ED3D;
	Tue,  2 Sep 2025 15:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yzXa+H9l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B35032ED25;
	Tue,  2 Sep 2025 15:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756827869; cv=none; b=nqr3klc4i/BPPDM3XuREG0U753ybZaMX01c+jUniKZ5bUIFo3A6u4MuRcfB6CEIYF3Kmb+6DFtLIPwukkrEO1BBMVa8OQA5oG4/zfOdumEfizlGRQtnxAbF1PzjOVkg8fKcemGRowURHlaYZyLhz1Vo2vNvb2UZzwmB9XwVtr6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756827869; c=relaxed/simple;
	bh=Rom7YdnDC+ei+ZjVb5OSPCLqbUce5PefOBT5Bkxh3rw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KxciEvLgLSEk7grcERIrVzK+H3FdT85BaZf8zv4/gx7XB9UgIhXXLJPppLWRIZaSTil2UkppXmGuovooxAAtRdW3qTdOBrURVi1Bch0qiPQnVfGzFxtnrLCW9I4Aj2GSCNu0HSwXUzizq/cyfmZK/+EE9338dPwQwa5V8CaU7Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yzXa+H9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D152C4CEF6;
	Tue,  2 Sep 2025 15:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756827868;
	bh=Rom7YdnDC+ei+ZjVb5OSPCLqbUce5PefOBT5Bkxh3rw=;
	h=From:Date:Subject:To:Cc:From;
	b=yzXa+H9lkZ8AWV1opiBTpjYlEiMDa0E/rX1m73BonlvUAodt65Vu5VDUI3ABo0vxf
	 +KAT9XNQRNRG85ZGAFI+XJn5R3IhNFIMBUureLtqgpty2RQ+j1tAQdS0IkxogliPLK
	 EKEG2KxIrArGkeGN+z5uRhh4WV0wJ984FTiTqSX4=
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date: Tue, 02 Sep 2025 11:44:19 -0400
Subject: [PATCH] Documentation: update maintainer-pgp-guide for latest best
 practices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-pgp-guide-updates-v1-1-62ac7312d3f9@linuxfoundation.org>
X-B4-Tracking: v=1; b=H4sIANIQt2gC/x3MQQqAIBBA0avErBtQKaiuEi1ER5tNiZMRhHdPW
 r7F/y8IZSaBpXsh083C59Gg+w7cbo9IyL4ZjDKjmpXBFBPGwp6wJG8vEpymoAbtgtajg9alTIG
 f/7lutX4KajRsYwAAAA==
X-Change-ID: 20250902-pgp-guide-updates-88f041cf115c
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
X-Mailer: b4 0.15-dev-dfb17
X-Developer-Signature: v=1; a=openpgp-sha256; l=19033;
 i=konstantin@linuxfoundation.org; h=from:subject:message-id;
 bh=Rom7YdnDC+ei+ZjVb5OSPCLqbUce5PefOBT5Bkxh3rw=;
 b=owGbwMvMwCW27YjM47CUmTmMp9WSGDK2C9zuXnr4ULKrzpMzLXeLZ1v7nrL65zb3jG5il5g14
 xPbaXdYOkpZGMS4GGTFFFnK9sVuCip86CGX3mMKM4eVCWQIAxenAExExpfhv0tKysLow1sf6Psb
 uh5PMp7SfW6X6/Er854f6rjl73719CVGho0HNIqd3jYmzeZ/6enOxsH/4LfyafFSW1mxxpqoEta
 HjAA=
X-Developer-Key: i=konstantin@linuxfoundation.org; a=openpgp;
 fpr=DE0E66E32F1FDD0902666B96E63EDCA9329DD07E

Freshen up the maintainer PGP guide:

- Bump minimum GnuPG version requirement from 2.2 to 2.4, since 2.2 is
  no longer maintained
- All major hardware tokens now support Curve25519, so remove outdated
  ECC support callouts
- Update hardware device recommendations (Nitrokey Pro 2 -> Nitrokey 3)
- Broaden backup media terminology (USB thumb drive -> external media)
- Update wording to follow vale's linter recommendations
- Various minor wording improvements for clarity

Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
---
 Documentation/process/maintainer-pgp-guide.rst | 158 ++++++++++++-------------
 1 file changed, 75 insertions(+), 83 deletions(-)

diff --git a/Documentation/process/maintainer-pgp-guide.rst b/Documentation/process/maintainer-pgp-guide.rst
index f5277993b195..b6919bf606c3 100644
--- a/Documentation/process/maintainer-pgp-guide.rst
+++ b/Documentation/process/maintainer-pgp-guide.rst
@@ -49,7 +49,7 @@ hosting infrastructure, regardless of how good the security practices
 for the latter may be.
 
 The above guiding principle is the reason why this guide is needed. We
-want to make sure that by placing trust into developers we do not simply
+want to make sure that by placing trust into developers we do not merely
 shift the blame for potential future security incidents to someone else.
 The goal is to provide a set of guidelines developers can use to create
 a secure working environment and safeguard the PGP keys used to
@@ -60,7 +60,7 @@ establish the integrity of the Linux kernel itself.
 PGP tools
 =========
 
-Use GnuPG 2.2 or later
+Use GnuPG 2.4 or later
 ----------------------
 
 Your distro should already have GnuPG installed by default, you just
@@ -69,9 +69,9 @@ To check, run::
 
     $ gpg --version | head -n1
 
-If you have version 2.2 or above, then you are good to go. If you have a
-version that is prior than 2.2, then some commands from this guide may
-not work.
+If you have version 2.4 or above, then you are good to go. If you have
+an earlier version, then you are using a release of GnuPG that is no
+longer maintained and some commands from this guide may not work.
 
 Configure gpg-agent options
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -199,13 +199,6 @@ separate signing subkey::
 
     $ gpg --quick-addkey [fpr] ed25519 sign
 
-.. note:: ECC support in GnuPG
-
-    Note, that if you intend to use a hardware token that does not
-    support ED25519 ECC keys, you should choose "nistp256" instead or
-    "ed25519." See the section below on recommended hardware devices.
-
-
 Back up your Certify key for disaster recovery
 ----------------------------------------------
 
@@ -213,7 +206,7 @@ The more signatures you have on your PGP key from other developers, the
 more reasons you have to create a backup version that lives on something
 other than digital media, for disaster recovery reasons.
 
-The best way to create a printable hardcopy of your private key is by
+A good way to create a printable hardcopy of your private key is by
 using the ``paperkey`` software written for this very purpose. See ``man
 paperkey`` for more details on the output format and its benefits over
 other solutions. Paperkey should already be packaged for most
@@ -224,11 +217,11 @@ key::
 
     $ gpg --export-secret-key [fpr] | paperkey -o /tmp/key-backup.txt
 
-Print out that file (or pipe the output straight to lpr), then take a
-pen and write your passphrase on the margin of the paper. **This is
-strongly recommended** because the key printout is still encrypted with
-that passphrase, and if you ever change it you will not remember what it
-used to be when you had created the backup -- *guaranteed*.
+Print out that file, then take a pen and write your passphrase on the
+margin of the paper. **This is strongly recommended** because the key
+printout is still encrypted with that passphrase, and if you ever change
+it you will not remember what it used to be when you had created the
+backup -- *guaranteed*.
 
 Put the resulting printout and the hand-written passphrase into an envelope
 and store in a secure and well-protected place, preferably away from your
@@ -236,10 +229,9 @@ home, such as your bank vault.
 
 .. note::
 
-    Your printer is probably no longer a simple dumb device connected to
-    your parallel port, but since the output is still encrypted with
-    your passphrase, printing out even to "cloud-integrated" modern
-    printers should remain a relatively safe operation.
+    The key is still encrypted with your passphrase, so printing out
+    even to "cloud-integrated" modern printers should remain a
+    relatively safe operation.
 
 Back up your whole GnuPG directory
 ----------------------------------
@@ -255,16 +247,17 @@ on these external copies whenever you need to use your Certify key --
 such as when making changes to your own key or signing other people's
 keys after conferences and summits.
 
-Start by getting a small USB "thumb" drive (preferably two!) that you
-will use for backup purposes. You will need to encrypt them using LUKS
--- refer to your distro's documentation on how to accomplish this.
+Start by getting an external media card (preferably two!) that you will
+use for backup purposes. You will need to create an encrypted partition
+on this device using LUKS -- refer to your distro's documentation on how
+to accomplish this.
 
 For the encryption passphrase, you can use the same one as on your
 PGP key.
 
-Once the encryption process is over, re-insert the USB drive and make
-sure it gets properly mounted. Copy your entire ``.gnupg`` directory
-over to the encrypted storage::
+Once the encryption process is over, re-insert your device and make sure
+it gets properly mounted. Copy your entire ``.gnupg`` directory over to
+the encrypted storage::
 
     $ cp -a ~/.gnupg /media/disk/foo/gnupg-backup
 
@@ -273,11 +266,10 @@ You should now test to make sure everything still works::
     $ gpg --homedir=/media/disk/foo/gnupg-backup --list-key [fpr]
 
 If you don't get any errors, then you should be good to go. Unmount the
-USB drive, distinctly label it so you don't blow it away next time you
-need to use a random USB drive, and put in a safe place -- but not too
-far away, because you'll need to use it every now and again for things
-like editing identities, adding or revoking subkeys, or signing other
-people's keys.
+device, distinctly label it so you don't overwrite it by accident, and
+put in a safe place -- but not too far away, because you'll need to use
+it every now and again for things like editing identities, adding or
+revoking subkeys, or signing other people's keys.
 
 Remove the Certify key from your homedir
 ----------------------------------------
@@ -303,7 +295,7 @@ and store it on offline storage.
     your GnuPG directory in its entirety. What we are about to do will
     render your key useless if you do not have a usable backup!
 
-First, identify the keygrip of your Certify key::
+First, identify the "keygrip" of your Certify key::
 
     $ gpg --with-keygrip --list-key [fpr]
 
@@ -328,8 +320,8 @@ Certify key fingerprint). This will correspond directly to a file in your
     2222000000000000000000000000000000000000.key
     3333000000000000000000000000000000000000.key
 
-All you have to do is simply remove the .key file that corresponds to
-the Certify key keygrip::
+It is sufficient to remove the .key file that corresponds to the Certify
+key keygrip::
 
     $ cd ~/.gnupg/private-keys-v1.d
     $ rm 1111000000000000000000000000000000000000.key
@@ -372,7 +364,7 @@ GnuPG operation is performed, the keys are loaded into system memory and
 can be stolen from there by sufficiently advanced malware (think
 Meltdown and Spectre).
 
-The best way to completely protect your keys is to move them to a
+A good way to completely protect your keys is to move them to a
 specialized hardware device that is capable of smartcard operations.
 
 The benefits of smartcards
@@ -383,11 +375,11 @@ private keys and performing crypto operations directly on the card
 itself. Because the key contents never leave the smartcard, the
 operating system of the computer into which you plug in the hardware
 device is not able to retrieve the private keys themselves. This is very
-different from the encrypted USB storage device we used earlier for
-backup purposes -- while that USB device is plugged in and mounted, the
+different from the encrypted media storage device we used earlier for
+backup purposes -- while that device is plugged in and mounted, the
 operating system is able to access the private key contents.
 
-Using external encrypted USB media is not a substitute to having a
+Using external encrypted media is not a substitute to having a
 smartcard-capable device.
 
 Available smartcard devices
@@ -398,17 +390,15 @@ easiest is to get a specialized USB device that implements smartcard
 functionality. There are several options available:
 
 - `Nitrokey Start`_: Open hardware and Free Software, based on FSI
-  Japan's `Gnuk`_. One of the few available commercial devices that
-  support ED25519 ECC keys, but offer fewest security features (such as
-  resistance to tampering or some side-channel attacks).
-- `Nitrokey Pro 2`_: Similar to the Nitrokey Start, but more
-  tamper-resistant and offers more security features. Pro 2 supports ECC
-  cryptography (NISTP).
+  Japan's `Gnuk`_. One of the cheapest options, but offers fewest
+  security features (such as resistance to tampering or some
+  side-channel attacks).
+- `Nitrokey 3`_: Similar to the Nitrokey Start, but more
+  tamper-resistant and offers more security features and USB
+  form-factors. Supports ECC cryptography (ED25519 and NISTP).
 - `Yubikey 5`_: proprietary hardware and software, but cheaper than
-  Nitrokey Pro and comes available in the USB-C form that is more useful
-  with newer laptops. Offers additional security features such as FIDO
-  U2F, among others, and now finally supports NISTP and ED25519 ECC
-  keys.
+  Nitrokey with a similar set of features. Supports ECC cryptography
+  (ED25519 and NISTP).
 
 Your choice will depend on cost, shipping availability in your
 geographical region, and open/proprietary hardware considerations.
@@ -419,8 +409,8 @@ geographical region, and open/proprietary hardware considerations.
     you `qualify for a free Nitrokey Start`_ courtesy of The Linux
     Foundation.
 
-.. _`Nitrokey Start`: https://shop.nitrokey.com/shop/product/nitrokey-start-6
-.. _`Nitrokey Pro 2`: https://shop.nitrokey.com/shop/product/nkpr2-nitrokey-pro-2-3
+.. _`Nitrokey Start`: https://www.nitrokey.com/products/nitrokeys
+.. _`Nitrokey 3`: https://www.nitrokey.com/products/nitrokeys
 .. _`Yubikey 5`: https://www.yubico.com/products/yubikey-5-overview/
 .. _Gnuk: https://www.fsij.org/doc-gnuk/
 .. _`qualify for a free Nitrokey Start`: https://www.kernel.org/nitrokey-digital-tokens-for-kernel-developers.html
@@ -455,7 +445,7 @@ the smartcard). You so rarely need to use the Admin PIN, that you will
 inevitably forget what it is if you do not record it.
 
 Getting back to the main card menu, you can also set other values (such
-as name, sex, login data, etc), but it's not necessary and will
+as name, gender, login data, etc), but it's not necessary and will
 additionally leak information about your smartcard should you lose it.
 
 .. note::
@@ -615,7 +605,7 @@ run::
 You can also use a specific date if that is easier to remember (e.g.
 your birthday, January 1st, or Canada Day)::
 
-    $ gpg --quick-set-expire [fpr] 2025-07-01
+    $ gpg --quick-set-expire [fpr] 2038-07-01
 
 Remember to send the updated key back to keyservers::
 
@@ -656,9 +646,9 @@ hundreds of cloned repositories floating around, how does anyone verify
 that their copy of linux.git has not been tampered with by a malicious
 third party?
 
-Or what happens if a backdoor is discovered in the code and the "Author"
-line in the commit says it was done by you, while you're pretty sure you
-had `nothing to do with it`_?
+Or what happens if malicious code is discovered in the kernel and the
+"Author" line in the commit says it was done by you, while you're pretty
+sure you had `nothing to do with it`_?
 
 To address both of these issues, Git introduced PGP integration. Signed
 tags prove the repository integrity by assuring that its contents are
@@ -681,8 +671,7 @@ should be used (``[fpr]`` is the fingerprint of your key)::
 How to work with signed tags
 ----------------------------
 
-To create a signed tag, simply pass the ``-s`` switch to the tag
-command::
+To create a signed tag, pass the ``-s`` switch to the tag command::
 
     $ git tag -s [tagname]
 
@@ -693,7 +682,7 @@ not been maliciously altered.
 How to verify signed tags
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 
-To verify a signed tag, simply use the ``verify-tag`` command::
+To verify a signed tag, use the ``verify-tag`` command::
 
     $ git verify-tag [tagname]
 
@@ -712,9 +701,9 @@ The merge message will contain something like this::
     # gpg: Signature made [...]
     # gpg: Good signature from [...]
 
-If you are verifying someone else's git tag, then you will need to
-import their PGP key. Please refer to the
-":ref:`verify_identities`" section below.
+If you are verifying someone else's git tag, you will first need to
+import their PGP key. Please refer to the ":ref:`verify_identities`"
+section below.
 
 Configure git to always sign annotated tags
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -728,16 +717,16 @@ configuration option::
 How to work with signed commits
 -------------------------------
 
-It is easy to create signed commits, but it is much more difficult to
-use them in Linux kernel development, since it relies on patches sent to
-the mailing list, and this workflow does not preserve PGP commit
-signatures. Furthermore, when rebasing your repository to match
-upstream, even your own PGP commit signatures will end up discarded. For
-this reason, most kernel developers don't bother signing their commits
-and will ignore signed commits in any external repositories that they
-rely upon in their work.
+It is also possible to create signed commits, but they have limited
+usefulness in Linux kernel development. The kernel contribution workflow
+relies on sending in patches, and converting commits to patches does not
+preserve git commit signatures. Furthermore, when rebasing your own
+repository on a newer upstream, PGP commit signatures will end up
+discarded. For this reason, most kernel developers don't bother signing
+their commits and will ignore signed commits in any external
+repositories that they rely upon in their work.
 
-However, if you have your working git tree publicly available at some
+That said, if you have your working git tree publicly available at some
 git hosting service (kernel.org, infradead.org, ozlabs.org, or others),
 then the recommendation is that you sign all your git commits even if
 upstream developers do not directly benefit from this practice.
@@ -748,7 +737,7 @@ We recommend this for the following reasons:
    provenance, even externally maintained trees carrying PGP commit
    signatures will be valuable for such purposes.
 2. If you ever need to re-clone your local repository (for example,
-   after a disk failure), this lets you easily verify the repository
+   after reinstalling your system), this lets you verify the repository
    integrity before resuming your work.
 3. If someone needs to cherry-pick your commits, this allows them to
    quickly verify their integrity before applying them.
@@ -756,9 +745,8 @@ We recommend this for the following reasons:
 Creating signed commits
 ~~~~~~~~~~~~~~~~~~~~~~~
 
-To create a signed commit, you just need to pass the ``-S`` flag to the
-``git commit`` command (it's capital ``-S`` due to collision with
-another flag)::
+To create a signed commit, pass the ``-S`` flag to the ``git commit``
+command (it's capital ``-S`` due to collision with another flag)::
 
     $ git commit -S
 
@@ -775,7 +763,6 @@ You can tell git to always sign commits::
 
 .. _verify_identities:
 
-
 How to work with signed patches
 -------------------------------
 
@@ -793,6 +780,11 @@ headers (a-la DKIM):
 Installing and configuring patatt
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
+.. note::
+
+    If you use B4 to send in your patches, patatt is already installed
+    and integrated into your workflow.
+
 Patatt is packaged for many distributions already, so please check there
 first. You can also install it from pypi using "``pip install patatt``".
 
@@ -835,9 +827,9 @@ encounters, for example::
 How to verify kernel developer identities
 =========================================
 
-Signing tags and commits is easy, but how does one go about verifying
-that the key used to sign something belongs to the actual kernel
-developer and not to a malicious imposter?
+Signing tags and commits is straightforward, but how does one go about
+verifying that the key used to sign something belongs to the actual
+kernel developer and not to a malicious imposter?
 
 Configure auto-key-retrieval using WKD and DANE
 -----------------------------------------------
@@ -884,7 +876,7 @@ various software makers dictating who should be your trusted certifying
 entity, PGP leaves this responsibility to each user.
 
 Unfortunately, very few people understand how the Web of Trust works.
-While it remains an important aspect of the OpenPGP specification,
+While it is still an important part of the OpenPGP specification,
 recent versions of GnuPG (2.2 and above) have implemented an alternative
 mechanism called "Trust on First Use" (TOFU). You can think of TOFU as
 "the SSH-like approach to trust." With SSH, the first time you connect
@@ -894,8 +886,8 @@ to connect, forcing you to make a decision on whether you choose to
 trust the changed key or not. Similarly, the first time you import
 someone's PGP key, it is assumed to be valid. If at any point in the
 future GnuPG comes across another key with the same identity, both the
-previously imported key and the new key will be marked as invalid and
-you will need to manually figure out which one to keep.
+previously imported key and the new key will be marked for verification
+and you will need to manually figure out which one to keep.
 
 We recommend that you use the combined TOFU+PGP trust model (which is
 the new default in GnuPG v2). To set it, add (or modify) the

---
base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
change-id: 20250902-pgp-guide-updates-88f041cf115c

Best regards,
--  
Konstantin Ryabitsev <konstantin@linuxfoundation.org>


